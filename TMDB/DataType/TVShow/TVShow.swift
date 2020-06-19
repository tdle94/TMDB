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
    let createdBy: List<CreatedBy> = List()
    let episodeRunTime: List<Int> = List()
    dynamic var firstAirDate: String = ""
    let genres: List<Genre> = List()
    dynamic var homepage: String = ""
    dynamic var id: Int = 0
    dynamic var inProduction: Bool = false
    let languages: List<String> = List()
    dynamic var lastAirDate: String = ""
    dynamic var lastEpisodeToAir: Episode?
    dynamic var name: String = ""
    dynamic var nextEpisodeToAir: Episode?
    let networks: List<Networks> = List()
    dynamic var numberOfEpisodes: Int = 0
    dynamic var numberOfSeasons: Int = 0
    dynamic var originCountry: List<String> = List()
    dynamic var originalLanguage: String = ""
    dynamic var originalName: String = ""
    dynamic var overview: String = ""
    dynamic var popularity: Double = 0.0
    dynamic var posterPath: String?
    let productionCompanies: List<ProductionCompany> = List()
    dynamic var seasons: List<Season> = List()
    dynamic var status: String = ""
    dynamic var type: String = ""
    dynamic var voteAverage: Double = 0.0
    dynamic var voteCount: Int = 0
    dynamic var posterImgData: Data?

    enum CodingKeys: String, CodingKey {
        case genres, hompage, id, languages, name, networks, overview, popularity, seasons, status, type
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
        firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        name = try container.decode(String.self, forKey: .name)
        originalName = try container.decode(String.self, forKey: .originalName)
        
        let originCountry = try container.decode(List<String>.self, forKey: .originCountry)
        self.originCountry.append(objectsIn: originCountry)

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

        if let networks = try container.decodeIfPresent(List<Networks>.self, forKey: .networks) {
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
class Season: Object, Decodable {
    dynamic var airDate: String = ""
    dynamic var episodeCount: Int = 0
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var overview: String = ""
    dynamic var posterPath: String = ""
    dynamic var number: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, number
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
    dynamic var stillPath: String = ""
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
    dynamic var gender: Int = 0
    dynamic var profilePath: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, name, gender
        case creditId = "credit_id"
        case profilePath = "profile_path"
    }
}
