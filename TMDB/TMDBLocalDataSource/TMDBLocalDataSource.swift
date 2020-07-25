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
    func saveSimilarMovie(_ similarMovie: List<Movie>, to movieId: Int)
    func saveRecommendMovie(_ recommendMovie: List<Movie>, to movieId: Int)
    func saveMovieImages(_ movieImages: MovieImages, to movieId: Int)
    // tv show
    func getTVShow(id: Int) -> TVShow?
    func saveTVShow(_ tvShow: TVShow)
    func saveSimilarTVShow(_ similarTVShow: List<TVShow>, to tvShowId: Int)
    func saveRecommendTVShow(_ recommendTVShow: List<TVShow>,to tvShowId: Int)
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

    func saveMovieImages(_ movieImages: MovieImages, to movieId: Int) {
        realm.beginWrite()
        getMovie(id: movieId)?.movieImages = movieImages
        try? realm.commitWrite()
    }

    func getMovie(id: Int) -> Movie? {
        return realm.object(ofType: Movie.self, forPrimaryKey: id)
    }

    func saveMovie(_ movie: Movie) {
        realm.beginWrite()
        for (index, similarMovie) in (movie.similar?.movies ?? List<Movie>()).enumerated() {
            if let existedMovie = getMovie(id: similarMovie.id) {
                movie.similar?.movies[index] = existedMovie
            }
        }
        for (index, recommendMovie) in (movie.recommendations?.movies ?? List<Movie>()).enumerated() {
            if let existedMovie = getMovie(id: recommendMovie.id) {
                movie.recommendations?.movies[index] = existedMovie
            }
        }
        movie.region = NSLocale.current.regionCode
        movie.language = NSLocale.preferredLanguages.first
        realm.add(movie, update: .modified)
        try? realm.commitWrite()
    }

    func saveSimilarMovie(_ similarMovie: List<Movie>, to movieId: Int) {
        realm.beginWrite()
        let movie = getMovie(id: movieId)
        movie?.similar?.movies.append(objectsIn: similarMovie)
        movie?.similar?.page += 1
        try? realm.commitWrite()
    }

    func saveRecommendMovie(_ recommendMovie: List<Movie>, to movieId: Int) {
        realm.beginWrite()
        let movie = getMovie(id: movieId)
        movie?.recommendations?.movies.append(objectsIn: recommendMovie)
        movie?.recommendations?.page += 1
        try? realm.commitWrite()
    }

    // MARK: - tv show
    func getTVShow(id: Int) -> TVShow? {
        return realm.object(ofType: TVShow.self, forPrimaryKey: id)
    }

    func saveTVShow(_ tvShow: TVShow) {
        realm.beginWrite()
        for (index, similarTVShow) in (tvShow.similar?.onTV ?? List<TVShow>()).enumerated() {
            if let existedTVShow = getTVShow(id: similarTVShow.id) {
                tvShow.similar?.onTV[index] = existedTVShow
            }
        }
        for (index, recommendTVSHow) in (tvShow.recommendations?.onTV ?? List<TVShow>()).enumerated() {
            if let existedTVShow = getTVShow(id: recommendTVSHow.id) {
                tvShow.recommendations?.onTV[index] = existedTVShow
            }
        }
        tvShow.region = NSLocale.current.regionCode
        tvShow.language = NSLocale.preferredLanguages.first
        realm.add(tvShow, update: .modified)
        try? realm.commitWrite()
    }

    func saveSimilarTVShow(_ similarTVShow: List<TVShow>, to tvShowId: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        tvShow?.similar?.onTV.append(objectsIn: similarTVShow)
        tvShow?.similar?.page += 1
        try? realm.commitWrite()
    }

    func saveRecommendTVShow(_ recommendTVShow: List<TVShow>,to tvShowId: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        tvShow?.recommendations?.onTV.append(objectsIn: recommendTVShow)
        tvShow?.similar?.page += 1
        try? realm.commitWrite()
    }

    // MARK: - people
    func getPerson(id: Int) -> People? {
        return realm.object(ofType: People.self, forPrimaryKey: id)
    }

    func savePerson(_ person: People) {
        realm.beginWrite()
        for (index, movie) in (person.movieCredits?.cast ?? List<Movie>()).enumerated() {
            if let existedMovie = getMovie(id: movie.id) {
                person.movieCredits?.cast[index] = existedMovie
            }
        }
        for (index, tvShow) in (person.tvCredits?.cast ?? List<TVShow>()).enumerated() {
            if let existedTVShow = getTVShow(id: tvShow.id) {
                person.tvCredits?.cast[index] = existedTVShow
            }
        }
        person.region = NSLocale.current.regionCode
        person.language = NSLocale.preferredLanguages.first
        realm.add(person, update: .modified)
        try? realm.commitWrite()
    }
}
