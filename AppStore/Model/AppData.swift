//
//  AppData.swift
//  AppStore
//
//  Created by azsha on 05/11/2018.
//  Copyright © 2018 Scott. All rights reserved.
//

import Foundation

struct Response: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var results: [Results]
}

struct Results: Codable {
    var rank: Int?
    
    var artistName: String
    var id: String
    var name: String
    var artworkUrl100: String
}
