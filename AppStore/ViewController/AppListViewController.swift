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

class AppListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appDatas: [Response.Feed.Entry] = []
    let urlString = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App Store"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Alamofire.request(urlString, method: .get, parameters: nil,
                          encoding: JSONEncoding.default).rx.responseJSON().map {value -> [Response.Feed.Entry] in
                            let responseData = try? JSONDecoder().decode(Response.self, from: value as! Data)
                            let appEntrys = responseData!.feed.entry
                            return appEntrys
            }
            .subscribe(onNext: {
                self.appDatas = $0
                dump(self.appDatas)
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? AppDetailViewController {
            destinationController.appId = sender as? String
        }
    }
}

extension AppListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let row = indexPath.row
        
        cell.appData = appDatas[row]
        
        return cell
    }
}

extension AppListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.performSegue(withIdentifier: "showAppDetail", sender: appDatas[row].id)
    }
}

