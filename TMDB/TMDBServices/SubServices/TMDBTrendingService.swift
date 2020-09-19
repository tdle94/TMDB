//
//  TMDBTrendingService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

enum TrendingTime: String {
    case today
    case week
}

enum TrendingMediaType: String {
    case all
    case movie
    case tv
    case person
}

protocol TMDBTrendingService {
    func getTrending(page: Int, time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)
}
