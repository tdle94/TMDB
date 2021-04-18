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

// Use for movie and tv show discovery api
struct DiscoverQuery: Equatable {

    enum SortBy: Equatable {
        case popularity(order: Popularity)
        case voteAverage(order: VoteAverage)
        case voteCount(order: VoteCount)
        case none
        
        enum Popularity: String {
            case ascending = "popularity.asc"
            case descending = "popularity.desc"
        }

        enum VoteAverage: String {
            case ascending = "vote_average.asc"
            case descending = "vote_average.dsc"
        }

        enum VoteCount: String {
            case ascending = "vote_count.asc"
            case descending = "vote_count.desc"
        }
    }
    
    enum FilterQueryType {
        case movie
        case tv
    }
    
    var page: Int = 1
    var language: String?
    var region: String?
    var sortBy: SortBy = SortBy.none
    var certificationCountry: String?
    var certification: String?
    var includeVideo: Bool?
    var primaryReleaseYear: Int?
    var year: Int?
    var withPeople: String?
    var withGenres: String?
    var withOriginalLanguage: String?
    var keywords: [Keyword] = []
    var filterType: FilterQueryType
    
    var numberOfFilterCount: Int {
        var count = 0
        
        if language != nil {
            count += 1
        }
        
        if region != nil {
            count += 1
        }
        
        if sortBy != .none {
            count += 1
        }
        
        if certificationCountry != nil {
            count += 1
        }
        
        if certification != nil {
            count += 1
        }
        
        if includeVideo != nil {
            count += 1
        }
        
        if primaryReleaseYear != nil {
            count += 1
        }
        
        if year != nil {
            count += 1
        }
        
        if withPeople != nil {
            count += 1
        }
        
        if withGenres != nil {
            count += 1
        }
        
        if withOriginalLanguage != nil {
            count += 1
        }
        
        if keywords.isNotEmpty {
            count += 1
        }
        
        return count
    }
    
    init(type: FilterQueryType) {
        filterType = type
    }
    
    static func == (lhs: DiscoverQuery, rhs: DiscoverQuery) -> Bool {
        return
            lhs.sortBy == rhs.sortBy &&
            lhs.page == rhs.page &&
            lhs.language == rhs.language &&
            lhs.region == rhs.region &&
            lhs.certificationCountry == rhs.certificationCountry &&
            lhs.certification == rhs.certification &&
            lhs.includeVideo == rhs.includeVideo &&
            lhs.primaryReleaseYear == rhs.primaryReleaseYear &&
            lhs.year == rhs.year &&
            lhs.withPeople == rhs.withPeople &&
            lhs.withGenres == rhs.withGenres &&
            lhs.keywords.elementsEqual(rhs.keywords) &&
            lhs.withOriginalLanguage == rhs.withOriginalLanguage
    }
}
