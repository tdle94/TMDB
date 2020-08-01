//
//  TMDBServices+TMDBSearchService.swift
//  TMDB
//
//  Created by Tuyen Le on 11.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBSearchService {
    func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void) {
        let request = urlRequestBuilder.getMultiSearchURLRequest(query: query, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode, page: page)
        session.send(request: request, responseType: MultiSearchResult.self, completion: completion)
    }
}
