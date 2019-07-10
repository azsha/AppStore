//
//  InfoHeaderView.swift
//  AppStore
//
//  Created by azsha on 13/06/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Cosmos

class InfoHeaderView: UIView {
    let ratingLabel: UILabel = UILabel()
    let ratingView: CosmosView = CosmosView()
    let ratingCountLabel: UILabel = UILabel()
    let rankLabel: UILabel = UILabel()
    let categoryLabel: UILabel = UILabel()
    let ageLabel: UILabel = UILabel()
    let ageTextLabel: UILabel = UILabel()
    
    func setupData(appDeteilData: AppDetailData) {
        
    }
    
    override func layoutSubviews() {
        addSubview(rankLabel)
        
        rankLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(ratingView)
        
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(rankLabel.snp.right).offset(8)
        }
        
        addSubview(ratingCountLabel)
        
        ratingCountLabel.snp.makeConstraints { make in
            make.top.equalTo(rankLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
    }
}
