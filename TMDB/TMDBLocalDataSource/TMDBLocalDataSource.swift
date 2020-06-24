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
    // tv show
    func getTVShow(id: Int) -> TVShow?
    func saveTVShows(_ tvShows: List<TVShow>)
    func saveTVShow(_ tvShow: TVShow)
    // people
    func getPerson(id: Int) -> People?
    func savePeople(_ people: List<People>)
    func savePerson(_ person: People)
    // trending
    func saveTrendings(_ trending: List<Trending>)
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
        realm.add(movie, update: .modified)
        try? realm.commitWrite()
    }

    func saveMovies(_ movies: List<Movie>) {
        realm.beginWrite()
        realm.add(movies, update: .modified)
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

    func saveTVShows(_ tvShows: List<TVShow>) {
        realm.beginWrite()
        realm.add(tvShows, update: .modified)
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

    func savePeople(_ people: List<People>) {
        realm.beginWrite()
        realm.add(people, update: .modified)
        try? realm.commitWrite()
    }
    

    // MARK: - trending
    func saveTrendings(_ trendings: List<Trending>) {
        for trend in trendings {
            if let movie = trend.movie {
                saveMovie(movie)
            } else if let tv = trend.tv {
                saveTVShow(tv)
            } else if let person = trend.people {
                savePerson(person)
            }
        }
    }
}
