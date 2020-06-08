//
//  PopularMovie.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct PopularMovieResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let movies: [PopularMovie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
}

class PopularMovie: Decodable {
    let id: Int
    let posterPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    let mediaType: String?
    
    enum CodingKeys: String, CodingKey {
        case id, adult, overview, popularity, video, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case mediaType = "media_type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        video = try container.decode(Bool.self, forKey: .video)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        title = try container.decode(String.self, forKey: .title)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        mediaType = try container.decodeIfPresent(String.self, forKey: .mediaType)
    }
}


