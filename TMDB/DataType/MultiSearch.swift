//
//  MultiSearch.swift
//  TMDB
//
//  Created by Tuyen Le on 11.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

struct MultiSearchResult: Decodable {
    let page: Int
    let results: [MultiSearch]
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

@objcMembers
class MultiSearch: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var mediaType: String = ""
    dynamic var posterPath: String?
    
    // for movie
    dynamic var originalTitle: String?
    dynamic var releaseDate: String?
    // for tv
    dynamic var originalName: String?
    dynamic var firstAirDate: String?
    // for people
    dynamic var name: String?
    dynamic var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case profilePath = "profile_path"
        case mediaType = "media_type"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mediaType = try container.decode(String.self, forKey: .mediaType)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        // for movie
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        
        // for tv
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate)
        
        // for people
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    required override init() {
        super.init()
    }
}
