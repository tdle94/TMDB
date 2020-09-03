//
//  TMDBTrendingRepository.swift
//  TMDB
//
//  Created by Tuyen Le on 27.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBTrendingRepository {
    func getTrending(page: Int, time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)
}
