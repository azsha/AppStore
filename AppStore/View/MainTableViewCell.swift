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
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var appData: Response.Feed.Entry? {
        didSet {
            titleLabel.text = appData?.name.label
            categoryLabel.text = appData?.category.attributes.label
            appIconImageView.sd_setImage(with: URL(string: appData!.image[0].label))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appIconImageView.layer.masksToBounds = true
        appIconImageView.layer.cornerRadius = 7
        appIconImageView.layer.borderWidth = 0.5
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
