//
//  MovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Movie: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var adult: Bool = false
    dynamic var backdropPath: String?
    dynamic var budget: Double = 0.0
    dynamic var homepage: String?
    dynamic var imdbId: String?
    dynamic var originalLanguage: String = ""
    dynamic var originalTitle: String = ""
    dynamic var overview: String?
    dynamic var popularity: Double = 0.0
    dynamic var posterPath: String?
    dynamic var releaseDate: String?
    dynamic var revenue: Double = 0.0
    dynamic var runtime: Int = 0
    dynamic var status: String?
    dynamic var tagline: String?
    dynamic var title: String = ""
    dynamic var video: Bool = false
    dynamic var voteAverage: Double = 0.0
    dynamic var voteCount: Int = 0
    dynamic var belongToCollection: Collection?
    dynamic var region: String?
    dynamic var language: String?
    dynamic var videos: VideoResult?
    dynamic var recommendations: MovieResult?
    dynamic var similar: MovieResult?
    dynamic var credits: CreditResult?
    dynamic var keywords: KeywordResult?
    let genres: List<Genre> = List<Genre>()
    let spokenLanguages: List<SpokenLanguage> = List<SpokenLanguage>()
    let productionCompanies: List<ProductionCompany> = List<ProductionCompany>()
    let productionCountries: List<ProductionCountry> = List<ProductionCountry>()

    enum CodingKeys: String, CodingKey {
        case id, adult, budget, genres, homepage, overview, popularity, revenue, runtime, status, tagline, title, video, videos, similar, recommendations, credits, keywords
        case backdropPath = "backdrop_path"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case belongToCollection = "belongs_to_collection"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        video = try container.decode(Bool.self, forKey: .video)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        title = try container.decode(String.self, forKey: .title)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)

        budget = try container.decodeIfPresent(Double.self, forKey: .budget) ?? 0
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        revenue = try container.decodeIfPresent(Double.self, forKey: .revenue) ?? 0
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        status = try container.decodeIfPresent(String.self, forKey: .status)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        belongToCollection = try container.decodeIfPresent(Collection.self, forKey: .belongToCollection)
        videos = try container.decodeIfPresent(VideoResult.self, forKey: .videos)
        similar = try container.decodeIfPresent(MovieResult.self, forKey: .similar)
        recommendations = try container.decodeIfPresent(MovieResult.self, forKey: .recommendations)
        credits = try container.decodeIfPresent(CreditResult.self, forKey: .credits)
        keywords = try container.decodeIfPresent(KeywordResult.self, forKey: .keywords)

        if let genres = try container.decodeIfPresent(List<Genre>.self, forKey: .genres) {
            self.genres.append(objectsIn: genres)
        }

        if let spokenLanguages = try container.decodeIfPresent(List<SpokenLanguage>.self, forKey: .spokenLanguages) {
            self.spokenLanguages.append(objectsIn: spokenLanguages)
        }

        if let productionCompanies = try container.decodeIfPresent(List<ProductionCompany>.self, forKey: .productionCompanies) {
            self.productionCompanies.append(objectsIn: productionCompanies)
        }

        if let productionCountries = try container.decodeIfPresent(List<ProductionCountry>.self, forKey: .productionCountries) {
            self.productionCountries.append(objectsIn: productionCountries)
        }
    }

    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
class KeywordResult: Object, Decodable {
    let keywords: List<Keyword> = List()
    
    enum CodingKeys: String, CodingKey {
        case keywords
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        keywords.append(objectsIn: try container.decode(List<Keyword>.self, forKey: .keywords))
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Keyword: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    required init() {
        super.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
class Collection: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var posterPath: String?
    dynamic var backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
    }

    required init() {
        super.init()
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
class Genre: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var name: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers
class SpokenLanguage: Object, Decodable {
    dynamic var iso6391: String = ""
    dynamic var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case iso6391 = "iso_639_1"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        iso6391 = try container.decode(String.self, forKey: .iso6391)
    }
      
    required init() {
        super.init()
    }
}

@objcMembers
class ProductionCountry: Object, Decodable {
    dynamic var ios31661: String = ""
    dynamic var name: String = ""

    enum CodingKeys: String, CodingKey {
        case name
        case ios31661 = "iso_3166_1"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        ios31661 = try container.decode(String.self, forKey: .ios31661)
    }

    required init() {
        super.init()
    }

    override class func primaryKey() -> String? {
        return "ios31661"
    }
}

@objcMembers
class ProductionCompany: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var logoPath: String?
    dynamic var name: String = ""
    dynamic var originCountry: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        logoPath = try container.decodeIfPresent(String.self, forKey: .logoPath)
        originCountry = try container.decode(String.self, forKey: .originCountry)
    }

    required init() {
        super.init()
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
