//
//  TMDBServices+TMDBTVService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBTVService {
    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularTVURLRequest(page: page)
        session.send(request: request, responseType: PopularOnTVResult.self, completion: completion)
    }
}
