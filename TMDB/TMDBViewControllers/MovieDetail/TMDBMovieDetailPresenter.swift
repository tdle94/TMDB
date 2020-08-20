//
//  TMDBMovieDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 6/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieDetailPresenter {

    let repository: TMDBRepository = TMDBRepository.share

    private weak var movieDetailDelegate: TMDBMovieDetailDelegate?

    private lazy var movieResultHandler: (Result<MovieResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let movieResult):
            self.movieDetailDelegate?.displayMovies(Array(movieResult.movies))
        }
    }

    private lazy var movieDetailHandler: (Result<Movie, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let movie):
            self.movieDetailDelegate?.displayMovieDetail(movie)
        }
    }

    init(delegate: TMDBMovieDetailDelegate) {
        movieDetailDelegate = delegate
    }

    func getMovieDetail(movieId: Int) {
        repository.getMovieDetail(id: movieId, completion: movieDetailHandler)
    }

    func getMovieCast(movieId: Int) {
        let casts = repository.getMovieCast(from: movieId)
        movieDetailDelegate?.displayMovieCasts(casts)
    }

    func getMovieCrew(movieId: Int) {
        let crews = repository.getMovieCrew(from: movieId)
        movieDetailDelegate?.displayMovieCrews(crews)
    }

    func getSimilarMovie(movieId: Int) {
        repository.getSimilarMovies(from: movieId, page: 1, completion: movieResultHandler)
    }

    func getRecommendMovie(movieId: Int) {
        repository.getRecommendMovies(from: movieId, page: 1, completion: movieResultHandler)
    }
    
    func getBackdropImage(movieId: Int) {
        repository.getMovieImages(from: movieId) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let imageResult):
                self.movieDetailDelegate?.displayBackdropImage(Array(imageResult.backdrops))
            }
        }
    }

    func refreshMovieDetail(movieId: Int) {
        repository.refreshMovie(id: movieId, completion: movieDetailHandler)
    }
}
