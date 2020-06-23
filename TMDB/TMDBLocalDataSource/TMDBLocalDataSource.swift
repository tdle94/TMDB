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
        if let existedMovie = getMovie(id: movie.id) {
            movie.posterImgData = existedMovie.posterImgData
        }
        realm.add(movie, update: .modified)
        try? realm.commitWrite()
    }

    func saveMovies(_ movies: List<Movie>) {
        realm.beginWrite()
        for movie in movies where getMovie(id: movie.id) == nil {
            realm.add(movie, update: .modified)
        }
        try? realm.commitWrite()
    }

    // MARK: - tv show
    func getTVShow(id: Int) -> TVShow? {
        return realm.object(ofType: TVShow.self, forPrimaryKey: id)
    }

    func saveTVShow(_ tvShow: TVShow) {
        realm.beginWrite()
        if let existedTV = getTVShow(id: tvShow.id) {
            tvShow.posterImgData = existedTV.posterImgData
        }
        realm.add(tvShow, update: .modified)
        try? realm.commitWrite()
    }

    func saveTVShows(_ tvShows: List<TVShow>) {
        realm.beginWrite()
        for tvShow in tvShows where getTVShow(id: tvShow.id) == nil {
            realm.add(tvShow, update: .modified)
        }
        try? realm.commitWrite()
    }

    // MARK: - people
    func getPerson(id: Int) -> People? {
        return realm.object(ofType: People.self, forPrimaryKey: id)
    }

    func savePerson(_ person: People) {
        realm.beginWrite()
        if let exitedPerson = getPerson(id: person.id) {
            person.profileImgData = exitedPerson.profileImgData
        }
        realm.add(person, update: .modified)
        try? realm.commitWrite()
    }

    func savePeople(_ people: List<People>) {
        realm.beginWrite()
        for person in people where getPerson(id: person.id) == nil {
            realm.add(person, update: .modified)
        }
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
