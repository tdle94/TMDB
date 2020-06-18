//
//  TMDBLocalDataSource+TMDBLocalDataSourceProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

protocol TMDBLocalDataSourceProtocol {
    // movie detail
    func getMovieDetail(id: Int) -> MovieDetail?
    func saveMovie(_ movie: MovieDetail)
    // popular movie
    func savePopularMovies(_ movies: List<PopularMovie>)
    func savePopularMoviePosterImgData(_ movie: PopularMovie, _ data: Data)
    func getPopularMoviePosterImgData(_ movie: PopularMovie) -> Data?
}

class TMDBLocalDataSource: TMDBLocalDataSourceProtocol {

    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }

    convenience init() {
        self.init(realm: try! Realm())
    }

    // MARK: - movie detail

    func getMovieDetail(id: Int) -> MovieDetail? {
        return realm.object(ofType: MovieDetail.self, forPrimaryKey: id)
    }

    func saveMovie(_ movie: MovieDetail) {
        realm.beginWrite()
        if let _ = realm.object(ofType: MovieDetail.self, forPrimaryKey: movie.id) {
            realm.cancelWrite()
            return
        }
        realm.add(movie)
        try? realm.commitWrite()
    }

    // MARK: - popular movie

    func savePopularMovies(_ movies: List<PopularMovie>) {
        realm.beginWrite()
        for movie in movies {
            if realm.object(ofType: PopularMovie.self, forPrimaryKey: movie.id) == nil {
                realm.add(movie)
            }
        }
        try? realm.commitWrite()
    }

    func savePopularMoviePosterImgData(_ movie: PopularMovie, _ data: Data) {
        let popularMovie = realm.object(ofType: PopularMovie.self, forPrimaryKey: movie.id)
        realm.beginWrite()
        popularMovie?.posterImgData = data
        try? realm.commitWrite()
    }

    func getPopularMoviePosterImgData(_ movie: PopularMovie) -> Data? {
        realm.object(ofType: PopularMovie.self, forPrimaryKey: movie.id)?.posterImgData
    }
}
