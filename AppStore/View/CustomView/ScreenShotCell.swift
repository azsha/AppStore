//
//  ScreenShotCell.swift
//  AppStore
//
//  Created by azsha on 04/06/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class ScreenShotCell: UICollectionViewCell {
    var screenShotImagePath: String = "" {
        didSet {
            screenShotImageView.sd_setImage(with: URL(string: screenShotImagePath))
        }
    }
    
    var screenShotImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        addSubview(screenShotImageView)
        screenShotImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        screenShotImageView.layer.cornerRadius = 20
        screenShotImageView.layer.borderWidth = 0.5
        screenShotImageView.layer.borderColor = UIColor.lightGray.cgColor
        screenShotImageView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
