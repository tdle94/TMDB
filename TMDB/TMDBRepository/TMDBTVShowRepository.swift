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
    func getTVShowGenres(from tvShowId: Int) -> [Genre]
    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowCast(from tvShowId: Int) -> [Cast]
    func getTVShowCrew(from tvShowId: Int) -> [Crew]
    func getTVShowReviews(from tvShowId: Int) -> [Review]
    func refreshTVShow(id: Int, completion: @escaping (Result<TVShow, Error>) -> Void)
    func getTVShowSeasonDetail(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<Season, Error>) -> Void)
    func getTVShowImages(from tvShowId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
    func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<Episode, Error>) -> Void)
    func getTVShowEpisodeCast(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Cast]
    func getTVShowEpisodeCrew(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Crew]
    func getTVShowEpisodeGuestStar(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Cast]
    func getTVShowSeasonImage(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
    func getTVShowEpisodeImage(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
    func getTVShowOnTheAir(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowAiringToday(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTopRatedTVShow(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getAllTVShow(query: DiscoverQuery, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowSeasons(from tvShowId: Int) -> [Season]
    func getTVShowSeasonCasts(from tvShowId: Int, seasonNumber: Int) -> [Cast]
    func getTVShowSeasonCrews(from tvShowId: Int, seasonNumber: Int) -> [Crew]
}
