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
    let knownFor: List<PopularMovie> = List<PopularMovie>()
    dynamic var name: String = ""
    dynamic var popularity: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case id, adult, name, popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        profilePath = try container.decode(String.self, forKey: .profilePath)
        adult = try container.decode(Bool.self, forKey: .adult)
        name = try container.decode(String.self, forKey: .name)
        popularity = try container.decode(Double.self, forKey: .popularity)
        let knownFor = try container.decode(List<PopularMovie>.self, forKey: .knownFor)
        self.knownFor.append(objectsIn: knownFor)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        super.init()
    }
}
