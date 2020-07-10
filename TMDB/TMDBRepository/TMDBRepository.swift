//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Foundation

protocol TMDBRepositoryProtocol {
    // MARK: - movie
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getMovieReview(from movieId: Int) -> [Review]
    func getMovieCast(from movieId: Int) -> [Cast]
    func getMovieCrew(from movieId: Int) -> [Crew]
    func getMovieKeywords(from movieId: Int) -> [Keyword]
    // MARK: - trending
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)

    // MARK: - people
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)

    // MARK: - tv shows
    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)

    // MARK: - image configuration
    func updateImageConfig()
}

class TMDBRepository: TMDBRepositoryProtocol {
    let services: TMDBServices
    let localDataSource: TMDBLocalDataSourceProtocol
    var userSetting: TMDBUserSettingProtocol

    init(services: TMDBServices, localDataSource: TMDBLocalDataSourceProtocol, userSetting: TMDBUserSettingProtocol) {
        self.services = services
        self.localDataSource = localDataSource
        self.userSetting = userSetting
    }
    // MAKR: - movies

    func getMovieKeywords(from movieId: Int) -> [Keyword] {
        guard let keywords = localDataSource.getMovie(id: movieId)?.keywords?.keywords else {
            return []
        }
        return Array(keywords)
    }
    
    func getMovieCast(from movieId: Int) -> [Cast] {
        guard let cast = localDataSource.getMovie(id: movieId)?.credits?.cast else {
            return []
        }
        return Array(cast)
    }

    func getMovieCrew(from movieId: Int) -> [Crew] {
        guard let crew = localDataSource.getMovie(id: movieId)?.credits?.crew else {
            return []
        }
        return Array(crew)
    }

    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        if
            let movie = localDataSource.getMovie(id: id),
            movie.region == NSLocale.current.regionCode,
            movie.language == NSLocale.preferredLanguages.first {

            completion(.success(movie))
            return
        }

        services.getMovieDetail(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.localDataSource.saveMovie(movie)
                    completion(.success(movie))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        guard let movie =  localDataSource.getMovie(id: movieId), let similarMovie = movie.similar else {
            services.getSimilarMovies(from: movieId, page: page) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let popularMovieResult):
                        completion(.success(popularMovieResult))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            return
        }

        // get from cache
        if page <= similarMovie.page {
            let toMovie = (page * similarMovie.movies.count) / similarMovie.page - 1
            let result = MovieResult()
            result.movies.append(objectsIn: similarMovie.movies[0...toMovie])
            completion(.success(result))
            return
        }

        // new page
        services.getSimilarMovies(from: movieId, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let similarMovieResult):
                    self.localDataSource.saveSimilarMovie(similarMovieResult.movies, to: movie)
                    completion(.success(similarMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        guard let movie =  localDataSource.getMovie(id: movieId), let recommendMovie = movie.recommendations else {
            services.getRecommendMovies(from: movieId, page: page) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let popularMovieResult):
                        completion(.success(popularMovieResult))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            return
        }

        // get from cache
        if page <= recommendMovie.page {
            let toMovie = (page * recommendMovie.movies.count) / recommendMovie.page - 1
            let result = MovieResult()
            result.movies.append(objectsIn: recommendMovie.movies[0...toMovie])
            completion(.success(result))
            return
        }

        services.getRecommendMovies(from: movieId, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recommendMovieResult):
                    self.localDataSource.saveRecommendMovie(recommendMovieResult.movies, to: movie)
                    completion(.success(recommendMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        services.getPopularMovie(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularMovieResult):
                    completion(.success(popularMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getMovieReview(from movieId: Int) -> [Review] {
        guard let review = localDataSource.getMovie(id: movieId)?.reviews?.reviews else { return [] }
        return Array(review)
    }

    // MARK: - tv show

    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        services.getPopularOnTV(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularTVShowResult):
                    completion(.success(popularTVShowResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - trending

    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        services.getTrending(time: time, type: type) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trendingResult):
                    completion(.success(trendingResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - people
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void) {
        services.getPopularPeople(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularPeopleResult):
                    completion(.success(popularPeopleResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - images
    func updateImageConfig() {
        if
            let lastUpdateDate = userSetting.imageConfig.dateUpdate,
            let daysBetweenDates = Calendar.current.dateComponents([.day], from: lastUpdateDate, to: Date()).day,
            daysBetweenDates < 10 { return }

        services.updateImageConfig { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let imageConfigResult):
                    self.userSetting.imageConfig = imageConfigResult
                }
            }
        }
    }
}
