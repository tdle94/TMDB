//
//  PopularOnTV.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct PopularOnTVResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let onTV: [PopularOnTV]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case onTV = "results"
    }
}

struct PopularOnTV: Decodable {
    let id: Int
    let posterPath: String
    let popularity: Double
    let backdropPath: String
    let voteAverage: Double
    let overview: String
    let firstAirDate: String
    let originCountry: [String]
    let genreIds: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name: String
    let originalName: String
    
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
}
