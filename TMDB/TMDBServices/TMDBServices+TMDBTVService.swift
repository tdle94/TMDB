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
}
