//
//  TMDBTVService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBTVService {
    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowDetail(id: Int, completion: @escaping (Result<TVShow, Error>) -> Void)
    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
}
