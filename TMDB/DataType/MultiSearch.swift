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

class MultiSearch: Decodable, Hashable {
    let id: Int
    let mediaType: String
    let posterPath: String?
    
    // for movie
    let originalTitle: String?
    let releaseDate: String?
    // for tv
    let originalName: String?
    let firstAirDate: String?
    // for people
    let name: String?
    let profilePath: String?
    
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
    
    static func == (lhs: MultiSearch, rhs: MultiSearch) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
