//
//  AppDataModel.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import Foundation

struct Response: Codable {
    var feed: Feed
}

struct Feed: Codable {
    var entry: [Entry]
}

struct Entry: Codable {
    var name: Name
    var image: [Image]
    var id: Id
    var category: Category
    var rank: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case image = "im:image"
        case id
        case category
    }
}

struct Name: Codable {
    var label: String
}

struct Image: Codable {
    var label: String
}

struct Id: Codable {
    var attributes: Attributes
}

struct Category: Codable {
    var attributes: Attributes
}

struct Attributes: Codable {
    var id: String?
    var label: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "im:id"
        case label
    }
}

