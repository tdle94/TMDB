//
//  PopularOnTV.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct PopularOnTVResult: Decodable {
    let page: Int
    let totalPage: Int
    let totalResult: Int
    let onTV: [PopularOnTV]
}

struct PopularOnTV: Decodable {
    let id: Int
    let posterPath: String
    let popularity: Double
    let backdropPath: String
    let voteAverage: Double
    let overview: String
    let firstAirDate: String
    let originCountry: [String]
    let genreIds: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name: String
    let originalName: String
}
