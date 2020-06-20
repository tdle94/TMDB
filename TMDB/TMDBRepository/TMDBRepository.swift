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

    // MARK: - trending
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)

    // MARK: - popular

    // popular people
    func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)
    func getProfileImageData(from people: People, completion: @escaping (Result<Data, Error>) -> Void)

    // popular movie
    func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)
    func getPosterImageData(from movie: Movie, completion: @escaping (Result<Data, Error>) -> Void)

    // popular tv
    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)
    func getPosterImageData(from tvShow: TVShow, completion: @escaping (Result<Data, Error>) -> Void)

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

    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        if let movieDetail = localDataSource.getMovie(id: id) {
            completion(.success(movieDetail))
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

    func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void) {
        services.getPopularMovie(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularMovieResult):
                    self.localDataSource.saveMovies(popularMovieResult.movies)
                    completion(.success(popularMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void) {
        services.getPopularOnTV(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularTVShowResult):
                    self.localDataSource.saveTVShows(popularTVShowResult.onTV)
                    completion(.success(popularTVShowResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPosterImageData(from tvShow: TVShow, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let path = tvShow.posterPath else {
            completion(.failure(NSError(domain: "invalid url", code: 400, userInfo: nil)))
            return
        }

        if let data = localDataSource.getTVPosterImgData(tvShow) {
            completion(.success(data))
            return
        }

        services.getImageData(from: path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.localDataSource.saveTVPosterImgData(tvShow, data)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        services.getTrending(time: time, type: type, completion: completion)
    }

    func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void) {
        services.getPopularPeople(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularPeopleResult):
                    self.localDataSource.savePeople(popularPeopleResult.peoples)
                    completion(.success(popularPeopleResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getProfileImageData(from people: People, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let path = people.profilePath else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            return
        }
        
        if let data = localDataSource.getPersonProfileImgData(people) {
            completion(.success(data))
            return
        }

        services.getImageData(from: path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.localDataSource.savePersonProfileImgData(people, data)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPosterImageData(from movie: Movie, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let path = movie.posterPath else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            return
        }

        if let data = localDataSource.getMoviePosterImgData(movie) {
            completion(.success(data))
            return
        }

        services.getImageData(from: path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.localDataSource.saveMoviePosterImgData(movie, data)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

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
