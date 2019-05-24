//
//  AppStore.swift
//  AppStore
//
//  Created by azsha on 25/05/2019.
//  Copyright © 2019 Scott. All rights reserved.
//

import Foundation
import Moya

public enum Appstore {
    case all
    
}

extension Appstore: TargetType {
    public var baseURL: URL {
        return URL(string: "https://rss.itunes.apple.com/api/v1/kr/ios-apps/top-free")!
    }
    
    public var path: String {
        switch self {
        case .all:
            return "/all/100/explicit.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .all:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .all:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .all:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .all:
            return nil
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
