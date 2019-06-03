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
    let headerView: UIView = UIView()
    let titleLabel: UILabel = UILabel()
    let tableView: UITableView = UITableView()
    
    var appDatas: [AppData.Feed.Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        reactor = AppListViewReactor()
        reactor?.action.onNext(Reactor.Action.updateAppList)
    }
    
    override func setupView() {
        super.setupView()
         self.title = "App Store"
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(88)
        }
        
        headerView.backgroundColor = .white
        
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{  make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        titleLabel.text = "인기차트"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.register(AppListTableViewCell.self, forCellReuseIdentifier: "AppListTableViewCell")
        tableView.rowHeight = 88
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
            .bind(to: tableView.rx.items(cellIdentifier: "AppListTableViewCell", cellType: AppListTableViewCell.self)) { _ , element, cell in
                cell.appData = element
            }
            .disposed(by: disposeBag)
    }
}
