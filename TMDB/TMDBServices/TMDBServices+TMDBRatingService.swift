//
//  TMDBService+TMDBRatingService.swift
//  TMDB
//
//  Created by Tuyen Le on 9/27/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBRatingService {
    func postMovieRating(movieId: Int, rate: Double, completion: @escaping (Result<RatingResponse, Error>) -> Void) {
        let request = urlRequestBuilder.getPostMovieRatingURLRequest(movieId: movieId, rate: rate)
        session.send(request: request, responseType: RatingResponse.self, completion: completion)
    }
    
    func postTVShowRating(tvId: Int, rate: Double, completion: @escaping (Result<RatingResponse, Error>) -> Void) {
        let request = urlRequestBuilder.getPostTVShowRatingURLRequest(tvId: tvId, rate: rate)
        session.send(request: request, responseType: RatingResponse.self, completion: completion)
    }
}
