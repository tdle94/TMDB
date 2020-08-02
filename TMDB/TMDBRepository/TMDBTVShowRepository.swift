//
//  TMDBTVShowRepository.swift
//  TMDB
//
//  Created by Tuyen Le on 27.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBTVShowRepository {
    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)
    func getTVShowKeywords(from tvShowId: Int) -> [Keyword]
    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowCast(from tvShowId: Int) -> [Cast]
    func getTVShowCrew(from tvShowId: Int) -> [Crew]
    func getTVShowReviews(from tvShowId: Int) -> [Review]
    func refreshTVShow(id: Int, completion: @escaping (Result<TVShow, Error>) -> Void)
    func getTVShowSeasonDetail(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<Season, Error>) -> Void)
    func getTVShowImages(from tvShowId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
}
