//
//  AppDataModel.swift
//  AppStore
//
//  Created by Scott on 2018. 6. 22..
//  Copyright © 2018년 Scott. All rights reserved.
//

import Foundation

struct Response: Codable {
    struct Feed: Codable {
        struct Entry: Codable {
            struct Name: Codable {
                var label: String
            }
            
            struct Image: Codable {
                var label: String
            }

            struct Title: Codable {
                var label: String
            }
            
            struct Category: Codable {
                struct Attributes: Codable {
                    var label: String
                }
                var attributes: Attributes
            }
            
            var name: Name
            var image: [Image]
            var title: Title
            var category: Category
            
            private enum CodingKeys: String, CodingKey {
                case name = "im:name"
                case image = "im:image"
                case title
                case category
            }
        }
        var entry: [Entry]
    }
    var feed: Feed
}










