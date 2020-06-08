//
//  TrendingResult.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class TrendingResult: Object, Decodable {
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    let trending: List<Trending> = List<Trending>()
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case trending = "result"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)

        let trending = try container.decode(List<Trending>.self, forKey: .trending)
        self.trending.append(objectsIn: trending)
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Trending: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var mediaType: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mediaType = try container.decode(String.self, forKey: .mediaType)
    }

    required init() {
        super.init()
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
