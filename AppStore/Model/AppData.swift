//
//  AppData.swift
//  AppStore
//
//  Created by azsha on 05/11/2018.
//  Copyright © 2018 Scott. All rights reserved.
//

import Foundation

struct AppData: Decodable {
    /// Feed Json Array
    struct Feed: Decodable {
        /// Result Json Array
        struct Results: Decodable {
            /// Genres Json Array
            struct Genres: Decodable {
                var name: String
            }
            
            var rank: Int?
            var genres: [Genres]
            var artistName: String
            var id: String
            var name: String
            var artworkUrl100: String
            
        }
        
        var results: [Results]
    }
    
    var feed: Feed
}




