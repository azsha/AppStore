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

class AppDetailViewController: UIViewController {

    var appId: String?                                          //전달된 앱 아이디 정보
    var appDetailData: [AppDetailData.Results] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var category2Label: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var releaseNotesTextView: UITextView!
    
    @IBOutlet weak var screenshot1ImageView: UIImageView!
    @IBOutlet weak var screenshot2ImageView: UIImageView!
    @IBOutlet weak var screenshot3ImageView: UIImageView!
    @IBOutlet weak var screenshot4ImageView: UIImageView!
    @IBOutlet weak var screenshot5ImageView: UIImageView!
    @IBOutlet weak var screenshot6ImageView: UIImageView!
    
    //스크린샷 개수에 따라 보여주는 이미지 뷰 조정을 위한 LayoutConstraint
    @IBOutlet weak var screenshot1WidthLC: NSLayoutConstraint!
    @IBOutlet weak var screenshot2WidthLC: NSLayoutConstraint!
    @IBOutlet weak var screenshot3WidthLC: NSLayoutConstraint!
    @IBOutlet weak var screenshot4WidthLC: NSLayoutConstraint!
    @IBOutlet weak var screenshot5WidthLC: NSLayoutConstraint!
    @IBOutlet weak var screenshot6WidthLC: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var sellerLabel: UILabel!
    
    let provider = MoyaProvider<Appstore>()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }

    func requestData() {
        guard let appId = appId else { return }
        provider.rx.request(.appDetail(appId: appId)).subscribe({ [weak self] result in
            switch result {
            case .success(let response):
                guard let responseJSON = try? JSONDecoder().decode(AppDetailData.self, from: response.data) else { return }
                self?.appDetailData = responseJSON.results
                self?.setupView()
                
            case .error :
                print("Failure")
            }
        }).disposed(by: disposeBag)
    }
    
    func setupView() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.borderWidth = 0.5
        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        titleLabel.text = appDetailData.first?.title
        categoryLabel.text = appDetailData.first?.category.first
        descriptionTextView.text = appDetailData.first?.appDescription
    }
}
