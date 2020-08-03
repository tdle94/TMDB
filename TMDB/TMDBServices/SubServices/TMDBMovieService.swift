//
//  MovieService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBMovieService {
    func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getMovieCredit(from movieId: Int, completion: @escaping (Result<CreditResult, Error>) -> Void)
    func getMovieReview(page: Int, from movieId: Int, completion: @escaping (Result<ReviewResult, Error>) -> Void)
    func getMovieImages(from movieId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
}
