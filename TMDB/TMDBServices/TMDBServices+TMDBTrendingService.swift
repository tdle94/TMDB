//
//  TMDBServices+TMDBTrendingService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBTrendingService {
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTrendingURLRequest(time: time, type: type)
        session.send(request: request, responseType: TrendingResult.self, completion: completion)
    }
}
