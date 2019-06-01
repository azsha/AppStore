//
//  MainTableViewCell.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
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
        
        appIconImageView = UIImageView(frame: self.frame)
        titleLabel = UILabel(frame: self.frame)
        categoryLabel = UILabel(frame: self.frame)
        
        addSubview(appIconImageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        
        appIconImageView.layer.masksToBounds = true
        appIconImageView.layer.cornerRadius = 7
        appIconImageView.layer.borderWidth = 0.5
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
