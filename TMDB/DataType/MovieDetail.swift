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
class MovieDetail: Object, Decodable {
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
    dynamic var releaseDate: String = ""
    dynamic var revenue: Double = 0.0
    dynamic var runtime: Int = 0
    dynamic var status: String = ""
    dynamic var tagline: String?
    dynamic var title: String = ""
    dynamic var video: Bool = false
    dynamic var voteAverage: Double = 0.0
    dynamic var voteCount: Int = 0
    dynamic var belongToCollection: Bool?
    let genres: List<Genre> = List<Genre>()
    let spokenLanguages: List<SpokenLanguage> = List<SpokenLanguage>()
    let productionCompanies: List<ProductionCompany> = List<ProductionCompany>()
    let productionCountries: List<ProductionCountry> = List<ProductionCountry>()

    enum CodingKeys: String, CodingKey {
        case id, adult, budget, genres, homepage, overview, popularity, revenue, runtime, status, tagline, title, video
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
        budget = try container.decode(Double.self, forKey: .budget)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        revenue = try container.decode(Double.self, forKey: .revenue)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        status = try container.decode(String.self, forKey: .status)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        belongToCollection = try container.decodeIfPresent(Bool.self, forKey: .belongToCollection)

        let genres = try container.decode(List<Genre>.self, forKey: .genres)
        self.genres.append(objectsIn: genres)

        let spokenLanguages = try container.decode(List<SpokenLanguage>.self, forKey: .spokenLanguages)
        self.spokenLanguages.append(objectsIn: spokenLanguages)

        let productionCompanies = try container.decode(List<ProductionCompany>.self, forKey: .productionCompanies)
        self.productionCompanies.append(objectsIn: productionCompanies)

        let productionCountries = try container.decode(List<ProductionCountry>.self, forKey: .productionCountries)
        self.productionCountries.append(objectsIn: productionCountries)
    }
    
    convenience init(id: Int, adult: Bool, budget: Double,
                     homepage: String, overview: String, popularity: Double,
                     revenue: Double, runtime: Int, status: String,
                     tagline: String, title: String, video: Bool,
                     backdropPath: String, imdbId: String, originalLanguage: String,
                     originalTitle: String, releaseDate: String, voteAverage: Double, voteCount: Int) {
        self.init()
        self.id = id
        self.adult = adult
        self.budget = budget
        self.homepage = homepage
        self.overview = overview
        self.popularity = popularity
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.backdropPath = backdropPath
        self.imdbId = imdbId
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
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
