//
//  TMDBServices+TMDBMovieService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBMovieService {
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let request = urlRequestBuilder.getMovieDetailURLRequest(id: id)
        session.send(request: request, responseType: Movie.self, completion: completion)
    }

    func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularMovieURLRequest(page: page, language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode)
        session.send(request: request, responseType: PopularMovie.self, completion: completion)
    }

    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void) {
        let request = urlRequestBuilder.getSimilarMoviesURLRequest(from: movieId, page: page, language: NSLocale.preferredLanguages.first)
        session.send(request: request, responseType: PopularMovie.self, completion: completion)
    }

    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void) {
        let request = urlRequestBuilder.getRecommendMoviesURLRequest(from: movieId, page: page, language: NSLocale.preferredLanguages.first)
        session.send(request: request, responseType: PopularMovie.self, completion: completion)
    }
}
