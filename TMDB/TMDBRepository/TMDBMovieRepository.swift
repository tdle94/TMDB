//
//  TMDBMovieRepository.swift
//  TMDB
//
//  Created by Tuyen Le on 27.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBMovieRepository {
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getMovieReview(from movieId: Int) -> [Review]
    func getMovieCast(from movieId: Int) -> [Cast]
    func getMovieCrew(from movieId: Int) -> [Crew]
    func getMovieKeywords(from movieId: Int) -> [Keyword]
    func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults?
    func refreshMovie(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getMovieImages(from movieId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void)
}
