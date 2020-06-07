//
//  MovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let adult: Bool
    let backdropPath: String
    let budget: Double
    let genres: [Int]
    let homepage: String
    let imdbId: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Double
    let runtime: Int
    let spokenLanguage: [SpokenLanguage]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

struct SpokenLanguage: Decodable {
    let iso6391: String
    let name: String
}

struct ProductionCountry: Decodable {
    let ios31661: String
    let name: String
}

struct ProductionCompany: Decodable {
    let id: Int
    let logoPath: String
    let name: String
    let originCountry: String
}
