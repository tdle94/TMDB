//
//  TrendingResult.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct TrendingResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResult: Int
    let trending: [Trending]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResult = "total_results"
        case trending = "result"
    }
}

class Trending: Decodable {
    let id: Int
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
    }
}
