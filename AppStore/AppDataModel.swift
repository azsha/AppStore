//
//  AppDataModel.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppDataModel: NSObject {
    var appID: String                                   //앱 아이디
    var iconUrlPath: String                             //앱 아이콘 URL 경로
    var title: String                                   //앱 타이틀
    var category: String                                //앱 카테고리
    var iconImage: UIImage?                             //앱 아이콘 이미지
    
    var version: String?                                //앱 버전
    var appReleaseNote: String?                         //앱 릴리즈노트
    var appDescription: String?                         //앱 설명
    var sellerName: String?                             //앱 판매자
    
    var screenShotUrlPaths: [String]?                   //스크린샷 URL 경로
    var screenShotImages: [UIImage]?                    //스크린샷 이미지 배열
    
    //주요 정보 파싱
    init(json: JSON) {
        self.appID = json["id"]["attributes"]["im:id"].stringValue
        self.iconUrlPath = json["im:image"][2]["label"].stringValue
        self.title = json["im:name"]["label"].stringValue
        self.category = json["category"]["attributes"]["label"].stringValue
    }
    
    //추가 정보 파싱
    func addInfo(json: JSON) {
        self.version = json["version"].stringValue
        self.appReleaseNote = json["releaseNotes"].stringValue
        self.appDescription = json["description"].stringValue
        self.sellerName = json["sellerName"].stringValue
        
        let screenshotPaths = json["screenshotUrls"].arrayValue
        
        self.screenShotUrlPaths = []
        for screenshotPath in screenshotPaths {
            self.screenShotUrlPaths?.append(screenshotPath.stringValue)
        }
    }
    
    //아이콘 이미지 다운로드
    func downloadIconImage() {
        guard let imageUrl = URL(string: self.iconUrlPath) else { return }
        
        let data = try? Data(contentsOf: imageUrl)
        self.iconImage = data != nil ? UIImage(data: data!) : nil
    }
    
    //스크인샷 이미지 다운로드
    func downloadScreenShotImage() {
        guard let _ = screenShotUrlPaths else { return }
        
        self.screenShotImages = []
        for screenShotUrlPath in screenShotUrlPaths! {
            guard let imageUrl = URL(string: screenShotUrlPath) else { return }
            guard let data = try? Data(contentsOf: imageUrl) else { return }
            self.screenShotImages?.append(UIImage(data: data)!)
        }
    }
}
