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
class PeopleResult: Object, Decodable {
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    let peoples: List<People> = List<People>()
    
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
        let peoples = try container.decode(List<People>.self, forKey: .peoples)
        self.peoples.append(objectsIn: peoples)
    }
    
    required override init() {
        super.init()
    }
}
