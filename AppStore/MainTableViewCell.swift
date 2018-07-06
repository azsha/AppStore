//
//  MainTableViewCell.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    enum ImageDownloadState {
        case none
        case downloading
        case downloaded
    }
    
    var imageDownloadState: ImageDownloadState = .none
    
//    var appData: AppDataModel? {
//        didSet {
//            titleLabel.text = appData!.title
//            categoryLabel.text = appData!.category
//            
//            DispatchQueue.global().async {
//                let appIconImage = self.downloadImage(urlPath: self.appData!.iconUrlPath, state: self.imageDownloadState)
//                self.imageDownloadState = .downloading
//                
//                DispatchQueue.main.async {
//                    self.appIconImageView.image = appIconImage
//                    self.imageDownloadState = .downloaded
//                }
//            }
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appIconImageView.layer.masksToBounds = true
        appIconImageView.layer.cornerRadius = 7
        appIconImageView.layer.borderWidth = 0.5
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func downloadImage(urlPath: String, state: ImageDownloadState) -> UIImage? {
        guard state == .none else { return nil }
        guard let imageUrl = URL(string: urlPath) else { return nil }
        
        if let data = try? Data(contentsOf: imageUrl) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
