//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import UIKit
import Cosmos

class AppDetailViewController: UIViewController {

    //var appData: AppDataModel?                       //전달된 앱 정보
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
        
//        if let _ = appData?.version {
//            initView()
//        } else {
//            requestData()
//        }
    }

//    func requestData() {
//        let urlPath = "https://itunes.apple.com/lookup?id=\(appData!.appID)&country=kr"
//        print(urlPath)
//        guard let url = URL(string: urlPath) else {return}
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
//            do {
//                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
//                
//                let json = JSON(jsonResult)
//                let appInfo = json["results"].arrayValue.first
//                
//                //앱 정보 저장
//                self.appData?.addInfo(json: appInfo!)
//                
//                DispatchQueue.main.async {
//                    self.initView()
//                }
//            } catch {
//                print(error)
//            }
//        })
//        task.resume()
//    }
    
//    func initView() {
//        titleLabel.text = appData?.title
//        categoryLabel.text = appData?.category
//        iconImageView.image = appData?.iconImage
//
//        ageLabel.text = appData?.age
//        rankLabel.text = "#\(appData?.rank ?? 0)"
//        category2Label.text = appData?.category
//        reviewCountLabel.text = "\(appData?.reviewCount ?? 0)개의 평가"
//        ratingLabel.text = "\(appData?.rating ?? 0.0)"
//        ratingView.rating = appData!.rating!
//        ratingView.settings.fillMode = .half
//
//        versionLabel.text = "버전 \(appData!.version!)"
//        releaseNotesTextView.text = appData?.appReleaseNote
//
//        descriptionTextView.text = appData?.appDescription
//        sellerLabel.text = appData?.sellerName
//
//        if let _ = appData?.screenShotImages {
//            showScreenShots()
//        } else {
//            DispatchQueue.global().async {
//                self.appData?.downloadScreenShotImage()
//                DispatchQueue.main.async {
//                    self.showScreenShots()
//                }
//            }
//        }
//    }
    
    func showScreenShots() {
        let screenShotImageViews: [UIImageView] = [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView, screenshot4ImageView, screenshot5ImageView, screenshot6ImageView]
        
        let screenShotImageWidthLC: [NSLayoutConstraint] = [screenshot1WidthLC, screenshot2WidthLC, screenshot3WidthLC, screenshot4WidthLC, screenshot5WidthLC, screenshot6WidthLC]
        
        // 스크린샷이 6개 이하인 경우 이미지뷰 조정
//        for i in 0..<6 {
//            if i < appData!.screenShotImages!.count {
//                screenShotImageViews[i].image = appData!.screenShotImages![i]
//            } else {
//                screenShotImageWidthLC[i].constant = 0
//            }
//
//            screenShotImageViews[i].layer.masksToBounds = true
//            screenShotImageViews[i].layer.cornerRadius = 15
//        }
    }
    
    func initLayout() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.borderWidth = 0.5
        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    deinit {
        print("AppDetailViewController Deinit!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
