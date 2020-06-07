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
    let totalPage: Int
    let totalResult: Int
    let peoples: [PopularPeople]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPage = "total_page"
        case totalResult = "total_result"
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
