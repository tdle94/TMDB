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
    func saveSimilarMovie(_ similarMovies: List<Movie>, to movieId: Int)
    func saveRecommendMovie(_ recommendMovies: List<Movie>, to movieId: Int)
    func saveMovieImages(_ movieImages: ImageResult, to movieId: Int)
    // tv show
    func getTVShow(id: Int) -> TVShow?
    func saveTVShow(_ tvShow: TVShow)
    func saveSimilarTVShow(_ similarTVShows: List<TVShow>, to tvShowId: Int)
    func saveRecommendTVShow(_ recommendTVShows: List<TVShow>, to tvShowId: Int)
    func saveTVShowSeason(_ season: Season, to tvShowId: Int)
    func getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?
    func saveTVShowImages(_ tvShowImages: ImageResult, to tvShowId: Int)
    func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?
    func saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)
    func saveTVShowSeasonImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int)
    func saveTVShowEpisodeImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int, episodeNumber: Int)
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

    func saveMovieImages(_ movieImages: ImageResult, to movieId: Int) {
        realm.beginWrite()
        getMovie(id: movieId)?.images = movieImages
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
        movie.language = NSLocale.current.languageCode
        realm.add(movie, update: .modified)
        try? realm.commitWrite()
    }

    func saveSimilarMovie(_ similarMovies: List<Movie>, to movieId: Int) {
        realm.beginWrite()
        let movie = getMovie(id: movieId)
        var saveMovies: [Movie] = []
        
        for movie in similarMovies {
            let existedMovie = getMovie(id: movie.id)
            if existedMovie == nil {
                saveMovies.append(movie)
            } else {
                saveMovies.append(existedMovie!)
            }
        }
        movie?.similar?.movies.append(objectsIn: saveMovies)
        movie?.similar?.page += 1
        try? realm.commitWrite()
    }

    func saveRecommendMovie(_ recommendMovies: List<Movie>, to movieId: Int) {
        realm.beginWrite()
        let movie = getMovie(id: movieId)
        var saveMovies: [Movie] = []
        
        for movie in recommendMovies {
            let existedMovie = getMovie(id: movie.id)
            if existedMovie == nil {
                saveMovies.append(movie)
            } else {
                saveMovies.append(existedMovie!)
            }
        }

        movie?.recommendations?.movies.append(objectsIn: saveMovies)
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
        tvShow.language = NSLocale.current.languageCode
        realm.add(tvShow, update: .modified)
        try? realm.commitWrite()
    }

    func saveSimilarTVShow(_ similarTVShows: List<TVShow>, to tvShowId: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        var saveTVShows: [TVShow] = []
        
        for similarTVShow in similarTVShows {
            let existedTVShow = getTVShow(id: similarTVShow.id)
            if existedTVShow == nil {
                saveTVShows.append(similarTVShow)
            } else {
                saveTVShows.append(existedTVShow!)
            }
        }
        tvShow?.similar?.onTV.append(objectsIn: saveTVShows)
        tvShow?.similar?.page += 1
        try? realm.commitWrite()
    }

    func saveRecommendTVShow(_ recommendTVShows: List<TVShow>,to tvShowId: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        var saveTVShows: [TVShow] = []
        
        for recommendTVShow in recommendTVShows {
            let existedTVShow = getTVShow(id: recommendTVShow.id)
            if existedTVShow == nil {
                saveTVShows.append(recommendTVShow)
            } else {
                saveTVShows.append(existedTVShow!)
            }
        }
        tvShow?.recommendations?.onTV.append(objectsIn: saveTVShows)
        tvShow?.recommendations?.page += 1
        try? realm.commitWrite()
    }
    
    func saveTVShowSeason(_ season: Season, to tvShowId: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        if let seasonIndex = tvShow?.seasons.firstIndex(where: { $0.id == season.id }) {
            tvShow?.seasons[seasonIndex] = season
        }
        try? realm.commitWrite()
    }

    func getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season? {
        return getTVShow(id: tvShowId)?.seasons.first(where: { $0.number == seasonNumber })
    }
    
    func saveTVShowImages(_ tvShowImages: ImageResult, to tvShowId: Int) {
        realm.beginWrite()
        getTVShow(id: tvShowId)?.images = tvShowImages
        try? realm.commitWrite()
    }

    func saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        let season = tvShow?.seasons.first(where: { $0.number == seasonNumber })
        if
            let seasonIndex = tvShow?.seasons.firstIndex(where: { $0.number == seasonNumber }),
            let episodeIndex = season?.episodes.firstIndex(where: { $0.id == episode.id })
        {
            tvShow?.seasons[seasonIndex].episodes[episodeIndex] = episode
        }
        try? realm.commitWrite()
    }

    func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> Episode? {
        return getTVShow(id: tvShowId)?.seasons.first(where: { $0.number == seasonNumber })?.episodes.first(where: { $0.episodeNumber == episodeNumber })
    }

    func saveTVShowSeasonImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        let season = tvShow?.seasons.first(where: { $0.number == seasonNumber })
        season?.images = seasonImage
        try? realm.commitWrite()
    }

    func saveTVShowEpisodeImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        realm.beginWrite()
        let tvShow = getTVShow(id: tvShowId)
        let season = tvShow?.seasons.first(where: { $0.number == seasonNumber })
        let episode = season?.episodes.first(where: { $0.episodeNumber == episodeNumber })
        episode?.images = seasonImage
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
        person.language = NSLocale.current.languageCode
        realm.add(person, update: .modified)
        try? realm.commitWrite()
    }
}
