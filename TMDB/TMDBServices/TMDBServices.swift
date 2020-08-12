//
//  Services.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct TMDBServices {
    let session: TMDBSessionProtocol
    let urlRequestBuilder: TMDBURLRequestBuilderProtocol
}

struct DiscoverMovieQuery {
    enum SortBy {
        enum popularity: String {
            case ascending = "popularity.asc"
            case descending = "popularity.desc"
        }
        enum voteAverage: String {
            case ascending = "vote_average.asc"
            case descending = "vote_average.dsc"
        }
        enum voteCount: String {
            case ascending = "vote_count.asc"
            case descending = "vote_count.desc"
        }
    }
    
    let page: Int
    var language: String?
    var region: String?
    var sortBy: SortBy?
    var certificationCountry: String?
    var certification: String?
    var includeVideo: Bool?
    var primaryReleaseYear: Int?
    var year: Int?
    var withPeople: String?
    var withGenres: String?
    var withKeyword: String?
    var withOriginalLanguage: String?
}
