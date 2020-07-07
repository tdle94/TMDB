//
//  MovieReview.swift
//  TMDB
//
//  Created by Tuyen Le on 29.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class ReviewResult: Object, Decodable {
    dynamic var page: Int = 0
    dynamic var totalPages: Int = 0
    dynamic var totalResults: Int = 0
    let reviews: List<Review> = List()

    enum CodingKeys: String, CodingKey {
        case page
        case reviews = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        reviews.append(objectsIn: try container.decode(List<Review>.self, forKey: .reviews))
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Review: Object, Decodable {
    dynamic var author: String = ""
    dynamic var content: String = ""
    dynamic var id: String = ""
    dynamic var url: String = ""
}


