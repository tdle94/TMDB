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
    func saveSimilarMovie(_ similarMovie: List<Movie>, to movie: Movie)
    func saveRecommendMovie(_ recommendMovie: List<Movie>, to movie: Movie)
    // tv show
    func getTVShow(id: Int) -> TVShow?
    func saveTVShow(_ tvShow: TVShow)
    // people
    func getPerson(id: Int) -> People?
    func savePerson(_ person: People)
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
        movie.region = NSLocale.current.regionCode
        movie.language = NSLocale.preferredLanguages.first
        realm.add(movie, update: .modified)
        try? realm.commitWrite()
    }

    func saveSimilarMovie(_ similarMovie: List<Movie>, to movie: Movie) {
        realm.beginWrite()
        movie.similar?.movies.append(objectsIn: similarMovie)
        movie.similar?.page += 1
        try? realm.commitWrite()
    }

    func saveRecommendMovie(_ recommendMovie: List<Movie>, to movie: Movie) {
        realm.beginWrite()
        movie.recommendations?.movies.append(objectsIn: recommendMovie)
        movie.recommendations?.page += 1
        try? realm.commitWrite()
    }

    // MARK: - tv show
    func getTVShow(id: Int) -> TVShow? {
        return realm.object(ofType: TVShow.self, forPrimaryKey: id)
    }

    func saveTVShow(_ tvShow: TVShow) {
        realm.beginWrite()
        realm.add(tvShow, update: .modified)
        try? realm.commitWrite()
    }


    // MARK: - people
    func getPerson(id: Int) -> People? {
        return realm.object(ofType: People.self, forPrimaryKey: id)
    }

    func savePerson(_ person: People) {
        realm.beginWrite()
        realm.add(person, update: .modified)
        try? realm.commitWrite()
    }
}
