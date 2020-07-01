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
    func getMovieCredit(from movieId: Int, completion: @escaping (Result<CreditResult, Error>) -> Void)
    func getMovieReview(page: Int, from movieId: Int, completion: @escaping (Result<ReviewResult, Error>) -> Void)

    // MARK: - trending
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)

    // MARK: - people
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)

    // MARK: - tv shows
    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)

    // MARK: - image configuration
    func updateImageConfig()
    func getImageURL(from path: String) -> URL?
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
    
    func getMovieCredit(from movieId: Int, completion: @escaping (Result<CreditResult, Error>) -> Void) {
        if let creditResult = localDataSource.getMovieCredit(id: movieId) {
            completion(.success(creditResult))
            return
        }

        services.getMovieCredit(from: movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let credit):
                    self.localDataSource.saveMovieCredit(credit)
                    completion(.success(credit))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
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
    }

    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
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

    func getMovieReview(page: Int, from movieId: Int, completion: @escaping (Result<ReviewResult, Error>) -> Void) {
        services.getMovieReview(page: page, from: movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieReviewResult):
                    completion(.success(movieReviewResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
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

    func getImageURL(from path: String) -> URL? {
        return services.getImageURL(from: path)
    }
}
