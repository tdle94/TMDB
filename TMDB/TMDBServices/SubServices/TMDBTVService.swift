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
    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowSeasonDetail(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<Season, Error>) -> Void)
    func getTVShowImages(from tvShowId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
    func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<Episode, Error>) -> Void)
}
