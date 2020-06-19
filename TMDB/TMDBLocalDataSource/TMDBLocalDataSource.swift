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
    // movie
    func getMovie(id: Int) -> Movie?
    func saveMovie(_ movie: Movie)
    func saveMovies(_ movies: List<Movie>)
    func getMoviePosterImgData(_ movie: Movie) -> Data?
    func saveMoviePosterImgData(_ movie: Movie, _ data: Data)
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

    func getMovie(id: Int) -> Movie? {
        return realm.object(ofType: Movie.self, forPrimaryKey: id)
    }

    func saveMovie(_ movie: Movie) {
        realm.beginWrite()
        if let existedMovie = getMovie(id: movie.id) {
            movie.posterImgData = existedMovie.posterImgData
        }
        realm.add(movie, update: .modified)
        try? realm.commitWrite()
    }

    func saveMovies(_ movies: List<Movie>) {
        realm.beginWrite()
        for movie in movies where getMovie(id: movie.id) == nil {
            realm.add(movie)
        }
        try? realm.commitWrite()
    }

    func getMoviePosterImgData(_ movie: Movie) -> Data? {
        return getMovie(id: movie.id)?.posterImgData
    }

    func saveMoviePosterImgData(_ movie: Movie, _ data: Data) {
        realm.beginWrite()
        movie.posterImgData = data
        try? realm.commitWrite()
    }
}
