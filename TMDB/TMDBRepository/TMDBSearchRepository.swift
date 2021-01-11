//
//  TMDBSearchRepository.swift
//  TMDB
//
//  Created by Tuyen Le on 27.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBSearchRepository {
    func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)
    func searchKeyword(query: String, page: Int, completion: @escaping (Result<KeywordSearchResult, Error>) -> Void)
}
