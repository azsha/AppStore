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

class AppListViewController: BaseViewController, View {
    var tableView: UITableView = UITableView()
    
    var appDatas: [AppData.Feed.Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "App Store"
        
        tableView = UITableView(frame: self.view.frame)
        view.addSubview(tableView)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        reactor = AppListViewReactor()
        reactor?.action.onNext(Reactor.Action.updateAppList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController = segue.destination as? AppDetailViewController else { return }
        destinationController.appId = sender as? String
    }
    
    func bind(reactor: AppListViewReactor) {
        // Action
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let row = indexPath.row
                self?.performSegue(withIdentifier: "showAppDetail", sender: self?.reactor?.currentState.appList[row].id)
            })
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map{ $0.appList }
            .bind(to: tableView.rx.items(cellIdentifier: "MainTableViewCell", cellType: MainTableViewCell.self)) { _ , element, cell in
                cell.appData = element
            }
            .disposed(by: disposeBag)
    }
}
