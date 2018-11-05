//
//  AppData.swift
//  AppStore
//
//  Created by azsha on 05/11/2018.
//  Copyright © 2018 Scott. All rights reserved.
//

import Foundation

struct Response: Codable {
    struct Feed: Codable {
        struct Entry: Codable {
            struct Name: Codable { var label: String }
            struct Image: Codable { var label: String }
            struct Id: Codable {
                struct Attributes: Codable {
                    var id: String?
                    var label: String?
                    
                    private enum CodingKeys: String, CodingKey {
                        case id = "im:id"
                        case label
                    }
                }
                var attributes: Attributes
            }
            
            struct Category: Codable {
                struct Attributes: Codable {
                    var id: String?
                    var label: String?
                    
                    private enum CodingKeys: String, CodingKey {
                        case id = "im:id"
                        case label
                    }
                }
                var attributes: Attributes
            }
            
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
        var entry: [Entry]
    }
    var feed: Feed
}
