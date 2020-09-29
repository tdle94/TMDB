//
//  TMDBRatingRepository.swift
//  TMDB
//
//  Created by Tuyen Le on 9/27/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBRatingRepository {
    func postMovieRating(movieId: Int, rate: Double, completion: @escaping (Result<RatingResponse, Error>) -> Void)
    func postTVShowRating(tvId: Int, rate: Double, completion: @escaping (Result<RatingResponse, Error>) -> Void)
}
