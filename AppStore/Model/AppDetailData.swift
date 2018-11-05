//
//  AppDetailDataModel.swift
//  AppStore
//
//  Created by Scott on 2018. 7. 5..
//  Copyright © 2018년 Scott. All rights reserved.
//

import Foundation

struct AppDetailData: Codable {
    var appID: String                                           //앱 아이디
    var iconUrlPath: String                                     //앱 아이콘 URL 경로
    var title: String                                           //앱 타이틀
    var category: String                                        //앱 카테고리
    
    var age: String                                             //앱 사용 연령
    var rank: Int                                               //앱 순위
    var reviewCount: Int                                        //앱 리뷰 개수
    var rating: Double                                          //앱 별점
    var version: String                                         //앱 버전
    var appReleaseNote: String                                  //앱 릴리즈노트
    var appDescription: String                                  //앱 설명
    var sellerName: String                                      //앱 판매자
    
    var screenShotUrlPaths: [String]                            //스크린샷 URL 경로
}
