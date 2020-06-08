//
//  PopularOnTV.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PopularOnTVResult: Object, Decodable {
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    let onTV: List<PopularOnTV> = List<PopularOnTV>()
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case onTV = "results"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        let onTV = try container.decode(List<PopularOnTV>.self, forKey: .onTV)
        self.onTV.append(objectsIn: onTV)
    }

    required init() {
        super.init()
    }
}

@objcMembers
class PopularOnTV: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var posterPath: String = ""
    dynamic var popularity: Double = 0.0
    dynamic var backdropPath: String = ""
    dynamic var voteAverage: Double = 0.0
    dynamic var overview: String = ""
    dynamic var firstAirDate: String = ""
    dynamic var originalLanguage: String = ""
    dynamic var voteCount: Int = 0
    dynamic var name: String = ""
    dynamic var originalName: String = ""
    let originCountry: List<String> = List<String>()
    let genreIds: List<Int> = List<Int>()
    
    enum CodingKeys: String, CodingKey {
        case id, popularity, overview, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case originalName = "original_name"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        popularity = try container.decode(Double.self, forKey: .popularity)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        overview  = try container.decode(String.self, forKey: .overview)
        firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        name = try container.decode(String.self, forKey: .name)
        originalName = try container.decode(String.self, forKey: .originalName)
        
        let originCountry = try container.decode(List<String>.self, forKey: .originCountry)
        self.originCountry.append(objectsIn: originCountry)
        
        let genreIds = try container.decode(List<Int>.self, forKey: .genreIds)
        self.genreIds.append(objectsIn: genreIds)
    }

    required init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
