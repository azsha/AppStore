//
//  AppStore.swift
//  AppStore
//
//  Created by azsha on 25/05/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import Foundation
import Moya

/// AppStore API
public enum Appstore {
    /// All Apps
    case all
    
    case appDetail(appId: String)
}

extension Appstore: TargetType {
    public var baseURL: URL {
        switch self {
        case .all:
            return URL(string: "https://rss.itunes.apple.com/api/v1/kr/ios-apps/top-free")!
        case .appDetail:
            return URL(string: "https://itunes.apple.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .all:
            return "/all/100/explicit.json"
        case .appDetail:
            return "/lookup"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .all, .appDetail:
            return .get
            
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .all, .appDetail:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .all:
            return .requestPlain
        case .appDetail(let appId):
            return .requestParameters(
                parameters: ["id": appId, "country": "kr"],
                encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .all, .appDetail:
            return nil
            
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
