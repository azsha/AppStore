//
//  MainTableViewCell.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class AppListTableViewCell: UITableViewCell {
    fileprivate struct Metric {
        static let appIconImageViewLeft = 16.0
        static let appIconImageViewSize = 50.0
        static let titleLabelLeft = 16.0
        static let titleLabelTop = 12.0
        static let categoryLabelLeft = 16.0
        static let categoryLabelTop = 8.0
    }
    
    var appIconImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var categoryLabel: UILabel = UILabel()
    
    var appData: AppData.Feed.Results? {
        didSet {
            titleLabel.text = appData?.name
            categoryLabel.text = appData?.genres.first?.name
            appIconImageView.sd_setImage(with: URL(string: appData!.artworkUrl100))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(appIconImageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
    }
    
    override func layoutSubviews() {
        appIconImageView.snp.makeConstraints{ make in
            make.size.equalTo(CGSize(width: Metric.appIconImageViewSize, height: Metric.appIconImageViewSize))
            make.left.equalTo(self.contentView).offset(Metric.appIconImageViewLeft)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.left.equalTo(appIconImageView.snp.right).offset(Metric.titleLabelLeft)
            make.top.equalToSuperview().offset(Metric.titleLabelTop)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.left.equalTo(appIconImageView.snp.right).offset(Metric.categoryLabelLeft)
            make.top.equalTo(titleLabel.snp.bottom).offset(Metric.categoryLabelTop)
        }
        
        appIconImageView.layer.masksToBounds = true
        appIconImageView.layer.cornerRadius = 7
        appIconImageView.layer.borderWidth = 0.5
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
