//
//  PopularMovie.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PopularMovieResult: Object, Decodable {
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    let movies: List<PopularMovie> = List<PopularMovie>()
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        let movies = try container.decode(List<PopularMovie>.self, forKey: .movies)
        self.movies.append(objectsIn: movies)
        super.init()
    }

    required init() {
        super.init()
    }
}

@objcMembers
class PopularMovie: Object, Decodable {
    dynamic var id: Int = 0
    var posterPath: String?
    dynamic var adult: Bool = false
    dynamic var overview: String = ""
    dynamic var releaseDate: String?
    let genreIds: List<Int> = List<Int>()
    dynamic var originalTitle: String = ""
    dynamic var originalLanguage: String = ""
    dynamic var title: String = ""
    var backdropPath: String?
    dynamic var popularity: Double = 0.0
    dynamic var voteCount: Int = 0
    dynamic var video: Bool = false
    dynamic var voteAverage: Double = 0.0
    dynamic var mediaType: String?
    dynamic var posterImgData: Data?
    
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

        if container.contains(.popularity) {
            popularity = try container.decode(Double.self, forKey: .popularity)
        }
        
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        overview = try container.decode(String.self, forKey: .overview)
        video = try container.decode(Bool.self, forKey: .video)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        title = try container.decode(String.self, forKey: .title)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        mediaType = try container.decodeIfPresent(String.self, forKey: .mediaType)
        
        let genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.genreIds.append(objectsIn: genreIds)
    }
    
    required init() {
        super.init()
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
