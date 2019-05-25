//
//  AppDetailDataModel.swift
//  AppStore
//
//  Created by Scott on 2018. 7. 5..
//  Copyright © 2018년 Scott. All rights reserved.
//

import Foundation

struct AppDetailData: Decodable {
    struct Results: Decodable {
        var appId: Int                                              //앱 아이디
        var iconUrlPath: String                                     //앱 아이콘 URL 경로
        var title: String                                           //앱 타이틀
        var category: [String]                                       //앱 카테고리
        var age: String                                             //앱 사용 연령
        var rank: Int?                                              //앱 순위
        var reviewCount: Int                                        //앱 리뷰 개수
        var rating: Double                                          //앱 별점
        var version: String                                         //앱 버전
        var appReleaseNote: String                                  //앱 릴리즈노트
        var appDescription: String                                  //앱 설명
        var sellerName: String                                      //앱 판매자
        var screenShotUrlPaths: [String]                            //스크린샷 URL 경로
        
        enum CodingKeys: String, CodingKey {
            case appId = "trackId"
            case iconUrlPath = "artworkUrl100"
            case title = "trackCensoredName"
            case category = "genres"
            case age = "contentAdvisoryRating"
            //case rank
            case reviewCount = "userRatingCount"
            case rating = "averageUserRating"
            case version = "version"
            case appReleaseNote = "releaseNotes"
            case appDescription = "description"
            case sellerName = "artistName"
            case screenShotUrlPaths = "screenshotUrls"
        }
    }

    var results: [Results]
}
