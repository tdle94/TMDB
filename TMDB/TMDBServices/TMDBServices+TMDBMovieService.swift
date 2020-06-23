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
        let language: String? = userSetting.language != nil && userSetting.region != nil ? "\(userSetting.language!)-\(userSetting.region!)" : nil
        let request = urlRequestBuilder.getPopularMovieURLRequest(page: page, language: language, region: userSetting.region)
        session.send(request: request, responseType: PopularMovie.self, completion: completion)
    }
}
