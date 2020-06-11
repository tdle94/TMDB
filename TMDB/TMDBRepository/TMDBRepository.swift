//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct TMDBRepository {
    let services: TMDBServices  = TMDBServices(session: TMDBSession(), urlRequestBuilder: TMDBURLRequestBuilder())
    let localDataSource: TMDBLocalDataSourceProtocol = TMDBLocalDataSource()

    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        if let movieDetail = localDataSource.getMovieDetail(id: id) {
            completion(.success(movieDetail))
            return
        }

        services.getMovieDetail(id: id) { result in
            do {
                let movie = try result.get()
                if let error = self.localDataSource.save(movie: movie) {
                    completion(.failure(error))
                } else {
                    completion(.success(movie))
                }
            } catch let error {
                completion(.failure(error))
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
}
