//
//  TMDBServices+TMDBTVService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBTVService {
    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularTVURLRequest(page: page, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: TVShowResult.self, completion: completion)
    }

    func getTVShowDetail(id: Int, completion: @escaping (Result<TVShow, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowDetailURLRequest(id: id, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: TVShow.self, completion: completion)
    }

    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        let request = urlRequestBuilder.getSimilarTVShowsURLRequest(from: tvShowId, page: page, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: TVShowResult.self, completion: completion)
    }
    
    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        let request = urlRequestBuilder.getRecommendTVShowURLRequest(from: tvShowId, page: page, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: TVShowResult.self, completion: completion)
    }
    
    func getTVShowSeasonDetail(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<Season, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowSeasonDetailURLRequest(tvShowId: tvShowId, seasonNumber: seasonNumber, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: Season.self, completion: completion)
    }

    func getTVShowImages(from tvShowId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowImagesURLRequest(from: tvShowId)
        session.send(request: request, responseType: ImageResult.self, completion: completion)
    }
    
    func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<Episode, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowEpisodeURLRequest(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: Episode.self, completion: completion)
    }

    func getTVShowSeasonImage(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowSeasonImageURLRequest(from: tvShowId, seasonNumber: seasonNumber)
        session.send(request: request, responseType: ImageResult.self, completion: completion)
    }

    func getTVShowEpisodeImage(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowEpisodeImageURLRequest(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        session.send(request: request, responseType: ImageResult.self, completion: completion)
    }

    func getTVShowOnTheAir(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowOnTheAirURLRequest(page: page, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: TVShowResult.self, completion: completion)
    }

    func getTVShowAiringToday(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTVShowOnTheAirURLRequest(page: page, language: NSLocale.current.languageCode)
        session.send(request: request, responseType: TVShowResult.self, completion: completion)
    }
}
