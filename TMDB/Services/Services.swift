//
//  Services.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct Services {

    let session: SessionProtocol
    
    let urlRequestBuilder: URLRequestBuilderProtocol

    func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovieResult, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularMovieURLRequest(page: page)
        session.send(request: request, responseType: PopularMovieResult.self, completion: completion)
    }
    
    func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularPeopleURLRequest(page: page)
        session.send(request: request, responseType: PopularPeopleResult.self, completion: completion)
    }
    
    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularTVURLRequest(page: page)
        session.send(request: request, responseType: PopularOnTVResult.self, completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let request = urlRequestBuilder.getMovieDetailURLRequest(id: id)
        session.send(request: request, responseType: MovieDetail.self, completion: completion)
    }

    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        let request = urlRequestBuilder.getTrendingURLRequest(time: time, type: type)
        session.send(request: request, responseType: TrendingResult.self, completion: completion)
    }
}
