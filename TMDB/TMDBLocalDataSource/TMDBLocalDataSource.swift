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
    // tv show
    func getTVShow(id: Int) -> TVShow?
    func saveTVShows(_ tvShows: List<TVShow>)
    func saveTVPosterImgData(_ tvShow: TVShow, _ data: Data)
    func getTVPosterImgData(_ tvShow: TVShow) -> Data?
    // people
    func getPerson(id: Int) -> People?
    func savePeople(_ people: List<People>)
    func savePersonProfileImgData(_ person: People, _ data: Data)
    func getPersonProfileImgData(_ person: People) -> Data?
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

    // MARK: - tv show
    func getTVShow(id: Int) -> TVShow? {
        return realm.object(ofType: TVShow.self, forPrimaryKey: id)
    }

    func saveTVShows(_ tvShows: List<TVShow>) {
        realm.beginWrite()
        for tvShow in tvShows where getTVShow(id: tvShow.id) == nil {
            realm.add(tvShow)
        }
        try? realm.commitWrite()
    }

    func saveTVPosterImgData(_ tvShow: TVShow, _ data: Data) {
        realm.beginWrite()
        tvShow.posterImgData = data
        try? realm.commitWrite()
    }

    func getTVPosterImgData(_ tvShow: TVShow) -> Data? {
        return getTVShow(id: tvShow.id)?.posterImgData
    }

    // MARK: - people
    func getPerson(id: Int) -> People? {
        return realm.object(ofType: People.self, forPrimaryKey: id)
    }

    func savePeople(_ people: List<People>) {
        realm.beginWrite()
        for person in people where getPerson(id: person.id) == nil {
            realm.add(person)
        }
        try? realm.commitWrite()
    }
    
    func savePersonProfileImgData(_ person: People, _ data: Data) {
        realm.beginWrite()
        person.profileImgData = data
        try? realm.commitWrite()
    }
    
    func getPersonProfileImgData(_ person: People) -> Data? {
        return getPerson(id: person.id)?.profileImgData
    }
}
