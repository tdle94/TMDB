//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 11/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift

protocol MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository { get }
    var movie: PublishSubject<Movie> { get }
    var images: PublishSubject<[Images]> { get }
    var keywords: PublishSubject<[Keyword]> { get }
    var genres: PublishSubject<[Genre]> { get }
    var credits: PublishSubject<[MovieDetailModel]> { get }
    var isThereSimilarMovie: Bool { get }
    var isThereRecommendMovie: Bool { get }
    var isThereCast: Bool { get }
    var isThereCrew: Bool { get }
    
    func getMovieDetail(movieId: Int)
    func getImages(movieId: Int)
    func getCasts(movieId: Int)
    func getCrews(movieId: Int)
    func getSimilarMovies(movieId: Int)
    func getRecommendMovies(movieId: Int)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository
    var movie: PublishSubject<Movie> = PublishSubject()
    var images: PublishSubject<[Images]> = PublishSubject()
    var keywords: PublishSubject<[Keyword]> = PublishSubject()
    var genres: PublishSubject<[Genre]> = PublishSubject()
    var credits: PublishSubject<[MovieDetailModel]> = PublishSubject()
    var isThereSimilarMovie: Bool = true
    var isThereRecommendMovie: Bool = true
    var isThereCast: Bool = true
    var isThereCrew: Bool = true
    
    init(movieRepository: TMDBMovieRepository) {
        repository = movieRepository
    }
    
    func getMovieDetail(movieId: Int) {
        repository.getMovieDetail(id: movieId) { result in
            switch result {
            case .success(let movieDetailResult):
                self.movie.onNext(movieDetailResult)
                self.genres.onNext(Array(movieDetailResult.genres))
                
                if let keywordResult = movieDetailResult.keywords {
                    self.keywords.onNext(Array(keywordResult.keywords))
                }
                
                var moviesLikeThisOne: [Movie] = []
                
                if movieDetailResult.similar?.movies.isEmpty ?? true && movieDetailResult.recommendations?.movies.isEmpty ?? true {
                    self.isThereRecommendMovie = false
                    self.isThereSimilarMovie = false
                } else if movieDetailResult.similar?.movies.isEmpty ?? true {
                    self.isThereSimilarMovie = false
                    moviesLikeThisOne.append(contentsOf: Array(movieDetailResult.recommendations!.movies))
                } else if movieDetailResult.recommendations?.movies.isEmpty ?? true {
                    self.isThereRecommendMovie = false
                    moviesLikeThisOne.append(contentsOf: Array(movieDetailResult.similar!.movies))
                } else {
                    moviesLikeThisOne.append(contentsOf: Array(movieDetailResult.similar!.movies))
                }
                
                var credits = Array(movieDetailResult.credits?.cast ?? List<Cast>()).map { CustomElementType(identity: $0) }
                
                if credits.isEmpty {
                    self.isThereCast = false
                    credits = Array(movieDetailResult.credits?.crew ?? List<Crew>()).map { CustomElementType(identity: $0) }
                }
                
                if credits.isEmpty {
                    self.isThereCrew = false
                }

                self.credits.onNext([
                    .Credits(items: credits),
                    .MoviesLikeThis(items: moviesLikeThisOne.map { CustomElementType(identity: $0) }),
                ])

            case .failure(let error):
                self.movie.onError(error)
            }
        }
    }
    
    func getImages(movieId: Int) {
        repository.getMovieImages(from: movieId) { result in
            switch result {
            case .success(let imageResult):
                self.images.onNext(Array(imageResult.backdrops))
            case .failure(let error):
                self.images.onError(error)
            }
        }
    }
    
    func getCasts(movieId: Int) {
        let casts = repository.getMovieCast(from: movieId).map { CustomElementType(identity: $0) }
        self.credits.onNext([.Credits(items: casts)])
    }
    
    func getCrews(movieId: Int) {
        let crews = repository.getMovieCrew(from: movieId).map { CustomElementType(identity: $0) }
        self.credits.onNext([.Credits(items: crews)])
    }
    
    func getSimilarMovies(movieId: Int) {
        repository.getSimilarMovies(from: movieId, page: 1) { result in
            switch result {
            case .success(let movieResult):
                let movies = Array(movieResult.movies).map { CustomElementType(identity: $0) }
                self.credits.onNext([.MoviesLikeThis(items: movies)])
            case .failure(let error):
                self.credits.onError(error)
            }
        }
    }
    
    func getRecommendMovies(movieId: Int) {
        repository.getRecommendMovies(from: movieId, page: 1) { result in
            switch result {
            case .success(let movieResult):
                let movies = Array(movieResult.movies).map { CustomElementType(identity: $0) }
                self.credits.onNext([.MoviesLikeThis(items: movies)])
            case .failure(let error):
                self.credits.onError(error)
            }
        }
    }
}
