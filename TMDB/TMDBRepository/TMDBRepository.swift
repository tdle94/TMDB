//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Foundation

protocol TMDBRepositoryProtocol {
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
    func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovieResult, Error>) -> Void)
    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)
    func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)
    func getImageData(from url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

struct TMDBRepository: TMDBRepositoryProtocol {
    let services: TMDBServices
    let localDataSource: TMDBLocalDataSourceProtocol

    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        if let movieDetail = localDataSource.getMovieDetail(id: id) {
            completion(.success(movieDetail))
            return
        }

        services.getMovieDetail(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    if !self.localDataSource.save(movie: movie) {
                        completion(.failure(NSError()))
                    } else {
                        completion(.success(movie))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovieResult, Error>) -> Void) {
        services.getPopularMovie(page: page, completion: completion)
    }
    
    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void) {
        services.getPopularOnTV(page: page, completion: completion)
    }
    
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        services.getTrending(time: time, type: type, completion: completion)
    }
    
    func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void) {
        services.getPopularPeople(page: page, completion: completion)
    }

    func getImageData(from url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        services.getImageData(from: url, completion: completion)
    }
}
