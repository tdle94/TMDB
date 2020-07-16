//
//  People.swift
//  TMDB
//
//  Created by Tuyen Le on 19.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class People: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var profilePath: String?
    dynamic var adult: Bool = false
    dynamic var name: String = ""
    dynamic var popularity: Double = 0.0
    dynamic var birthday: String?
    dynamic var deathday: String?
    dynamic var knownForDepartment: String = ""
    let alsoKnownAs: List<String> = List()
    dynamic var gender: Int = 0
    dynamic var biography: String = ""
    dynamic var placeOfBirth: String?
    dynamic var imdbId: String = ""
    dynamic var homepage: String?
    dynamic var movieCredits: MovieCredit?
    dynamic var tvCredits: TVCredit?
    dynamic var images: ImageProfile?
    dynamic var region: String?
    dynamic var language: String?
    let knownFor: List<KnownFor> = List<KnownFor>()
    
    enum CodingKeys: String, CodingKey {
        case birthday, deathday, id, name, gender, biography, popularity, adult, homepage, images
        case knownForDepartment = "known_for_department"
        case alsoKnownAs = "also_known_as"
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case imdbId = "imdb_id"
        case knownFor = "known_for"
        case tvCredits = "tv_credits"
        case movieCredits = "movie_credits"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        name = try container.decode(String.self, forKey: .name)
        popularity = try container.decode(Double.self, forKey: .popularity)
        deathday = try container.decodeIfPresent(String.self, forKey: .deathday)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        images = try container.decodeIfPresent(ImageProfile.self, forKey: .images)
        movieCredits = try container.decodeIfPresent(MovieCredit.self, forKey: .movieCredits)
        tvCredits = try container.decodeIfPresent(TVCredit.self, forKey: .tvCredits)

        if container.contains(.birthday) {
            birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        }

        if container.contains(.knownForDepartment) {
            knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        }

        if container.contains(.alsoKnownAs) {
            alsoKnownAs.append(objectsIn: try container.decode(List<String>.self, forKey: .alsoKnownAs))
        }

        if container.contains(.gender) {
            gender = try container.decode(Int.self, forKey: .gender)
        }

        if container.contains(.biography) {
            biography = try container.decode(String.self, forKey: .biography)
        }

        if container.contains(.placeOfBirth) {
            placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
        }

        if container.contains(.imdbId) {
            imdbId = try container.decode(String.self, forKey: .imdbId)
        }

        if container.contains(.knownFor) {
            knownFor.append(objectsIn: try container.decode(List<KnownFor>.self, forKey: .knownFor))
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        super.init()
    }
}

@objcMembers
class MovieCredit: Object, Decodable {
    let cast: List<Movie> = List()
    
    enum CodingKeys: String, CodingKey {
        case cast
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let casts = try container.decode(List<Movie>.self, forKey: .cast)
        let uniqueCasts: List<Movie> = List()

        for uniqueCast in casts {
            if !uniqueCasts.contains(where: { $0.id == uniqueCast.id }) {
                uniqueCasts.append(uniqueCast)
            }
        }

        cast.append(objectsIn: uniqueCasts)
    }

    required init() {
        super.init()
    }
}

@objcMembers
class TVCredit: Object, Decodable {
    let cast: List<TVShow> = List()
    
    enum CodingKeys: String, CodingKey {
        case cast
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let casts = try container.decode(List<TVShow>.self, forKey: .cast)
        let uniqueCasts: List<TVShow> = List()

        for uniqueCast in casts {
            if !uniqueCasts.contains(where: { $0.id == uniqueCast.id }) {
                uniqueCasts.append(uniqueCast)
            }
        }
        cast.append(objectsIn: uniqueCasts)
    }

    required init() {
        super.init()
    }
}

@objcMembers
class ImageProfile: Object, Decodable {
    let profiles: List<Images> = List()
    
    enum CodingKeys: String, CodingKey {
        case profiles
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profiles.append(objectsIn: try container.decode(List<Images>.self, forKey: .profiles))
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Images: Object, Decodable {
    dynamic var aspectRatio: Double = 0.0
    dynamic var voteCount: Int = 0
    dynamic var voteAverage: Double = 0.0
    dynamic var filePath: String = ""
    dynamic var width: Int = 0
    dynamic var height: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case width, height
        case aspectRatio = "aspect_ratio"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case filePath = "file_path"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        aspectRatio = try container.decode(Double.self, forKey: .aspectRatio)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        filePath = try container.decode(String.self, forKey: .filePath)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }

    required init() {
        super.init()
    }
}

@objcMembers
class KnownFor: Object, Decodable {
    dynamic var mediaType: String = ""
    dynamic var popularMovie: Movie?
    dynamic var popularTV: TVShow?
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaType = try container.decode(String.self, forKey: .mediaType)

        if mediaType == "movie" {
            popularMovie = try Movie(from: decoder)
        } else if mediaType == "tv" {
            popularTV = try TVShow(from: decoder)
        }
    }

    required init() {
        super.init()
    }
}
