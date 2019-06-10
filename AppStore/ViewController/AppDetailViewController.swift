//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import Cosmos
import Moya
import RxSwift

class AppDetailViewController: BaseViewController {

    var appId: String?                                          //전달된 앱 아이디 정보
    var appDetailData: [AppDetailData.Results] = []
    
    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    
    let titleLabel: UILabel = UILabel()
    let categoryLabel: UILabel = UILabel()
    let iconImageView: UIImageView = UIImageView()
    
    let ageLabel: UILabel = UILabel()
    let rankLabel: UILabel = UILabel()
    let category2Label: UILabel = UILabel()
    let reviewCountLabel: UILabel = UILabel()
    let ratingLabel: UILabel = UILabel()
    let ratingView: CosmosView = CosmosView()
    
    let screenShotView: ScreenShotView = ScreenShotView()
    let versionLabel: UILabel = UILabel()
    let releaseNotesTextView: UITextView = UITextView()
    
    let descriptionTextView: UITextView = UITextView()
    let sellerLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }

    override func setupView() {
        super.setupView()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView).priority(.low)
        }
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(iconImageView.snp.right).offset(24)
        }
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(iconImageView.snp.right).offset(24)
        }
        
        contentView.addSubview(screenShotView)
        screenShotView.snp.makeConstraints{ make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(720)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func requestData() {
        guard let appId = appId else { return }
        provider.rx.request(.appDetail(appId: appId)).subscribe({ [weak self] result in
            switch result {
            case .success(let response):
                guard let responseJSON = try? JSONDecoder().decode(AppDetailData.self, from: response.data) else { return }
                self?.appDetailData = responseJSON.results
                self?.updateView()
                
                print(self?.appDetailData)
                
            case .error :
                print("Failure")
            }
        }).disposed(by: disposeBag)
    }
    
    func updateView() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.borderWidth = 0.5
        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        titleLabel.text = appDetailData.first?.title
        categoryLabel.text = appDetailData.first?.category.first
        descriptionTextView.text = appDetailData.first?.appDescription
        
        screenShotView.screenShotUrlPaths.onNext(appDetailData.first?.screenShotUrlPaths ?? [])
    }
}
