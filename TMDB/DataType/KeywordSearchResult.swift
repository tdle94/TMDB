//
//  KeywordSearchResult.swift
//  TMDB
//
//  Created by Tuyen Le on 1/10/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import Foundation

struct KeywordSearchResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Keyword]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
