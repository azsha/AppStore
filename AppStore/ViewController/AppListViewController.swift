//
//  ViewController.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya

class AppListViewController: BaseViewController, StoryboardView {
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
        
        reactor = AppListViewReactor()
        reactor?.action.onNext(Reactor.Action.updateAppList)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? AppDetailViewController {
            destinationController.appId = sender as? String
        }
    }
    
    func bind(reactor: AppListViewReactor) {
        // Action
        
        // State
        reactor.state
            .map{ $0.appList }
            .subscribe(onNext: { [weak self] appList in
                self?.appDatas = appList
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
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

