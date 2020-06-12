//
//  PopularPeople.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PopularPeopleResult: Object, Decodable {
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    let peoples: List<PopularPeople> = List<PopularPeople>()
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case peoples = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        let peoples = try container.decode(List<PopularPeople>.self, forKey: .peoples)
        self.peoples.append(objectsIn: peoples)
    }
    
    required init() {
        super.init()
    }
}

@objcMembers
class PopularPeople: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var profilePath: String = ""
    dynamic var adult: Bool = false
    dynamic var name: String = ""
    dynamic var popularity: Double = 0.0
    let knownFor: List< KnownFor> = List<KnownFor>()
    
    enum CodingKeys: String, CodingKey {
        case id, adult, name, popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        profilePath = try container.decode(String.self, forKey: .profilePath)
        name = try container.decode(String.self, forKey: .name)
        popularity = try container.decode(Double.self, forKey: .popularity)
        let knownFor = try container.decode(List<KnownFor>.self, forKey: .knownFor)
        self.knownFor.append(objectsIn: knownFor)
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
    dynamic var popularMovie: PopularMovie?
    dynamic var popularTV: PopularOnTV?
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaType = try container.decode(String.self, forKey: .mediaType)

        if mediaType == "movie" {
            popularMovie = try PopularMovie(from: decoder)
        } else {
            popularTV = try PopularOnTV(from: decoder)
        }
    }

    required init() {
        super.init()
    }
}
