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
    let knownFor: List<KnownFor> = List<KnownFor>()
    
    enum CodingKeys: String, CodingKey {
        case birthday, deathday, id, name, gender, biography, popularity, adult, homepage
        case knownForDepartment = "known_for_department"
        case alsoKnownAs = "also_known_as"
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case imdbId = "imdb_id"
        case knownFor = "known_for"
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


        if container.contains(.birthday) {
            birthday = try container.decode(String.self, forKey: .birthday)
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
            placeOfBirth = try container.decode(String.self, forKey: .placeOfBirth)
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
