//
//  PopularPeople.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct PopularPeopleResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let peoples: [PopularPeople]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case peoples = "results"
    }
}

struct PopularPeople: Decodable {
    let id: Int
    let profilePath: String
    let adult: Bool
    let knownFor: [PopularMovie]
    let name: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case id, adult, name, popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}
