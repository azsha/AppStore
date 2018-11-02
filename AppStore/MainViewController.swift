//
//  ViewController.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

extension Request: ReactiveCompatible { }

extension Reactive where Base: DataRequest {
    func responseJSON() -> Observable<Any> {
        return Observable.create({ observer in
            let request = self.base.responseData { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create(with: request.cancel)
        })
    }
}


class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appEntrys: [Entry] = []                   //앱 정보 배열
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App Store"
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        _ = Alamofire.request("https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json", method: .get, parameters: nil, encoding: JSONEncoding.default).rx.responseJSON()
            .map { value -> [Entry] in
                let responseData = try? JSONDecoder().decode(Response.self, from: value as! Data)
                let appEntrys = responseData!.feed.entry
                return appEntrys
            }
            .subscribe(onNext: {
                self.appEntrys = $0
                dump(self.appEntrys)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // RxSwift 를 사용한 방법
    func getData() -> Observable<[Entry]> {
        let urlString = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
        
        return Observable.create({ emitter in
            let url = URL(string: urlString)!
            URLSession().dataTask(with: url) { (data, response, error) in
                guard error == nil else { return }
                let responseData = try? JSONDecoder().decode(Response.self, from: data!)
                let appEntrys = responseData!.feed.entry
                
                emitter.onNext(appEntrys)
                emitter.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    // 기존 GCD를 사용한 방법
    func requestData() {
        let urlPath = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
        guard let url = URL(string: urlPath) else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                let responseData = try JSONDecoder().decode(Response.self, from: data!)
                self.appEntrys = responseData.feed.entry
                (0..<self.appEntrys.count).forEach{ self.appEntrys[$0].rank = $0 + 1 }
                dump(self.appEntrys)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? AppDetailViewController {
            destinationController.appId = sender as? String
        }
        
        //destinationController.appData = sender as? AppDataModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appEntrys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let row = indexPath.row
        
        cell.appData = appEntrys[row]
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.performSegue(withIdentifier: "showAppDetail", sender: appEntrys[row].id)
    }
}

