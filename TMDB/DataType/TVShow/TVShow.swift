//
//  TVShow.swift
//  TMDB
//
//  Created by Tuyen Le on 6/18/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class TVShow: Object, Decodable {
    dynamic var backdropPath: String?
    dynamic var firstAirDate: String = ""
    dynamic var id: Int = 0
    dynamic var inProduction: Bool = false
    dynamic var lastAirDate: String = ""
    dynamic var lastEpisodeToAir: Episode?
    dynamic var name: String = ""
    dynamic var nextEpisodeToAir: Episode?
    dynamic var numberOfEpisodes: Int = 0
    dynamic var numberOfSeasons: Int = 0
    dynamic var originalLanguage: String = ""
    dynamic var originalName: String = ""
    dynamic var overview: String = ""
    dynamic var popularity: Double = 0.0
    dynamic var posterPath: String?
    dynamic var status: String = ""
    dynamic var type: String = ""
    dynamic var voteAverage: Double = 0.0
    dynamic var voteCount: Int = 0
    dynamic var homepage: String = ""
    dynamic var keywords: TVKeywordResult?
    dynamic var language: String?
    dynamic var region: String?
    dynamic var recommendations: TVShowResult?
    dynamic var similar: TVShowResult?
    dynamic var credits: CreditResult?
    dynamic var reviews: ReviewResult?
    dynamic var videos: VideoResult?
    let genres: List<Genre> = List()
    let createdBy: List<CreatedBy> = List()
    let episodeRunTime: List<Int> = List()
    let languages: List<String> = List()
    let networks: List<Networks> = List()
    let originCountry: List<String> = List()
    let productionCompanies: List<ProductionCompany> = List()
    let seasons: List<Season> = List()

    enum CodingKeys: String, CodingKey {
        case genres, hompage, id, languages, name, networks, overview, popularity, seasons, status, type, keywords, recommendations, similar, credits, reviews, videos
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case inProduction = "in_production"
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case nextEpisodeToAir = "next_episode_to_air"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
        firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate) ?? ""
        homepage = try container.decodeIfPresent(String.self, forKey: .hompage) ?? ""
        inProduction = try container.decodeIfPresent(Bool.self, forKey: .inProduction) ?? false
        lastAirDate = try container.decodeIfPresent(String.self, forKey: .lastAirDate) ?? ""
        numberOfSeasons = try container.decodeIfPresent(Int.self, forKey: .numberOfSeasons) ?? 0
        numberOfEpisodes = try container.decodeIfPresent(Int.self, forKey: .numberOfEpisodes) ?? 0
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""

        lastEpisodeToAir = try container.decodeIfPresent(Episode.self, forKey: .lastEpisodeToAir)
        nextEpisodeToAir = try container.decodeIfPresent(Episode.self, forKey: .nextEpisodeToAir)

        id = try container.decode(Int.self, forKey: .id)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        overview  = try container.decode(String.self, forKey: .overview)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        name = try container.decode(String.self, forKey: .name)
        originalName = try container.decode(String.self, forKey: .originalName)
        keywords = try container.decodeIfPresent(TVKeywordResult.self, forKey: .keywords)
        recommendations = try container.decodeIfPresent(TVShowResult.self, forKey: .recommendations)
        similar = try container.decodeIfPresent(TVShowResult.self, forKey: .similar)
        credits = try container.decodeIfPresent(CreditResult.self, forKey: .credits)
        reviews = try container.decodeIfPresent(ReviewResult.self, forKey: .reviews)
        videos = try container.decodeIfPresent(VideoResult.self, forKey: .videos)
        originCountry.append(objectsIn: try container.decode(List<String>.self, forKey: .originCountry))

        if let seasons = try container.decodeIfPresent(List<Season>.self, forKey: .seasons) {
            self.seasons.append(objectsIn: seasons)
        }

        if let genre = try container.decodeIfPresent(List<Genre>.self, forKey: .genres) {
            self.genres.append(objectsIn: genre)
        }

        if let createdBy = try container.decodeIfPresent(List<CreatedBy>.self, forKey: .createdBy) {
            self.createdBy.append(objectsIn: createdBy)
        }

        if let episodeRunTime = try container.decodeIfPresent(List<Int>.self, forKey: .episodeRunTime) {
            self.episodeRunTime.append(objectsIn: episodeRunTime)
        }

        if let languages = try container.decodeIfPresent(List<String>.self, forKey: .languages) {
            self.languages.append(objectsIn: languages)
        }

        if
            let networks = try container.decodeIfPresent(List<Networks>.self, forKey: .networks),
            realm?.object(ofType: TVShow.self, forPrimaryKey: id)?.networks.isEmpty ?? true {
            // because logo path JSON object for recommend tvshow is in a different format. Only decode if it is not in real
            self.networks.append(objectsIn: networks)
        }

        if let productionCompanies = try container.decodeIfPresent(List<ProductionCompany>.self, forKey: .productionCompanies) {
            self.productionCompanies.append(objectsIn: productionCompanies)
        }
    }
    
    required init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
class TVKeywordResult: Object, Decodable {
    let results: List<Keyword> = List()
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results.append(objectsIn: try container.decode(List<Keyword>.self, forKey: .results))
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Season: Object, Decodable {
    dynamic var airDate: String?
    dynamic var episodeCount: Int = 0
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var overview: String = ""
    dynamic var posterPath: String?
    dynamic var number: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case number = "season_number"
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
    }
}

@objcMembers
class Networks: Object, Decodable {
    dynamic var name: String = ""
    dynamic var id: Int = 0
    dynamic var logoPath: String = ""
    dynamic var originCountry: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        originCountry = try container.decode(String.self, forKey: .originCountry)
        logoPath = try container.decodeIfPresent(String.self, forKey: .logoPath) ?? ""
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Episode: Object, Decodable {
    dynamic var airDate: String = ""
    dynamic var episodeNumber: Int = 0
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var overview: String = ""
    dynamic var productionCode: String = ""
    dynamic var seasonNumber: Int = 0
    dynamic var showId: Int = 0
    dynamic var stillPath: String?
    dynamic var voteAverage: Double = 0
    dynamic var voteCount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case showId = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

class CreatedBy: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var creditId: String = ""
    dynamic var name: String = ""
    dynamic var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case creditId = "credit_id"
        case profilePath = "profile_path"
    }
}
