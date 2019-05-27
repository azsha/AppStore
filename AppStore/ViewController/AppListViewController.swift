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
import Moya

class AppListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var appDatas: [AppData.Feed.Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App Store"
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        provider.rx.request(.all).subscribe({ [weak self] result in
            switch result {
            case .success(let response):
                guard let responseJSON = try? JSONDecoder().decode(AppData.self, from: response.data) else { return }
                self?.appDatas = responseJSON.feed.results
                
                self?.tableView.reloadData()
                
            case .error :
                print("Failure")
            }
        }).disposed(by: disposeBag)
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

