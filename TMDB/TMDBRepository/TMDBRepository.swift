//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Foundation

protocol TMDBRepositoryProtocol {
    // MARK: - movie
    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)
    func getMovieReview(from movieId: Int) -> [Review]
    func getMovieCast(from movieId: Int) -> [Cast]
    func getMovieCrew(from movieId: Int) -> [Crew]
    func getMovieKeywords(from movieId: Int) -> [Keyword]
    func getMovieImages(from movieId: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)
    func getMovieImages(from movieId: Int) -> MovieImages?
    func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults?

    // MARK: - trending
    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)

    // MARK: - people
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)
    func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)
    func getTVCredits(from personId: Int) -> TVCredit?
    func getMovieCredits(from personId: Int) -> MovieCredit?
    func getPersonImageProfile(from personId: Int) -> ImageProfile?

    // MARK: - tv shows
    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)
    func getTVShowKeywords(from tvShowId: Int) -> [Keyword]
    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)
    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)

    // MARK: - image configuration
    func updateImageConfig()

    // MARK: - search
    func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)
}

class TMDBRepository: TMDBRepositoryProtocol {
    let services: TMDBServices
    let localDataSource: TMDBLocalDataSourceProtocol
    var userSetting: TMDBUserSettingProtocol

    init(services: TMDBServices, localDataSource: TMDBLocalDataSourceProtocol, userSetting: TMDBUserSettingProtocol) {
        self.services = services
        self.localDataSource = localDataSource
        self.userSetting = userSetting
    }
    // MAKR: - movies

    func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults? {
        return localDataSource.getMovie(id: movieId)?.releaseDates
    }

    func getMovieImages(from movieId: Int) -> MovieImages? {
        return localDataSource.getMovie(id: movieId)?.movieImages
    }

    func getMovieImages(from movieId: Int, completion: @escaping (Result<MovieImages, Error>) -> Void) {
        if let movieImages = localDataSource.getMovie(id: movieId)?.movieImages {
            completion(.success(movieImages))
            return
        }
        
        services.getMovieImages(from: movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieImages):
                    self.localDataSource.saveMovieImages(movieImages, to: movieId)
                    completion(.success(movieImages))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getMovieKeywords(from movieId: Int) -> [Keyword] {
        guard let keywords = localDataSource.getMovie(id: movieId)?.keywords?.keywords else {
            return []
        }
        return Array(keywords)
    }
    
    func getMovieCast(from movieId: Int) -> [Cast] {
        guard let cast = localDataSource.getMovie(id: movieId)?.credits?.cast else {
            return []
        }
        return Array(cast)
    }

    func getMovieCrew(from movieId: Int) -> [Crew] {
        guard let crew = localDataSource.getMovie(id: movieId)?.credits?.crew else {
            return []
        }
        return Array(crew)
    }

    func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        if
            let movie = localDataSource.getMovie(id: id),
            movie.region == NSLocale.current.regionCode,
            movie.language == NSLocale.preferredLanguages.first {

            completion(.success(movie))
            return
        }

        services.getMovieDetail(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.localDataSource.saveMovie(movie)
                    completion(.success(movie))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        guard let movie =  localDataSource.getMovie(id: movieId) else {
            completion(.failure(NSError(domain: "Cannot find movie \(movieId)", code: 400, userInfo: nil)))
            return
        }
        
        guard let similarMovie = movie.similar else {
            completion(.failure(NSError(domain: "movie \(movieId) does not have similar", code: 400, userInfo: nil)))
            return
        }

        // get from cache
        if page <= similarMovie.page {
            let fromMovie = similarMovie.movies.count / similarMovie.totalPages * (page - 1)
            let toMovie = similarMovie.totalResults / similarMovie.totalPages * page - 1
            let result = MovieResult()
            result.movies.append(objectsIn: similarMovie.movies[fromMovie...toMovie])
            completion(.success(result))
            return
        } else if page != similarMovie.page + 1 {
            // only consider next consecutive page
            completion(.failure(NSError(domain: "next page is not a consecutive of current page", code: 401, userInfo: nil)))
            return
        }

        // new page
        services.getSimilarMovies(from: movieId, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let similarMovieResult):
                    self.localDataSource.saveSimilarMovie(similarMovieResult.movies, to: movie)
                    completion(.success(similarMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        guard let movie = localDataSource.getMovie(id: movieId) else {
            completion(.failure(NSError(domain: "Cannot find movie \(movieId)", code: 400, userInfo: nil)))
            return
        }

        guard let recommendMovie = movie.recommendations else {
            completion(.failure(NSError(domain: "movie \(movieId) does not have recommendations", code: 400, userInfo: nil)))
            return
        }
        // get from cache
        if page <= recommendMovie.page {
            let fromMovie = recommendMovie.movies.count / recommendMovie.totalPages * (page - 1)
            let toMovie = recommendMovie.totalResults / recommendMovie.totalPages * page - 1
            let result = MovieResult()
            result.movies.append(objectsIn: recommendMovie.movies[fromMovie...toMovie])
            completion(.success(result))
            return
        } else if page != recommendMovie.page + 1 {
            // only consider next consecutive page
            completion(.failure(NSError(domain: "next page is not a consecutive of current page", code: 401, userInfo: nil)))
            return
        }

        // new page
        services.getRecommendMovies(from: movieId, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recommendMovieResult):
                    self.localDataSource.saveRecommendMovie(recommendMovieResult.movies, to: movie)
                    completion(.success(recommendMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        services.getPopularMovie(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularMovieResult):
                    completion(.success(popularMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getMovieReview(from movieId: Int) -> [Review] {
        guard let review = localDataSource.getMovie(id: movieId)?.reviews?.reviews else { return [] }
        return Array(review)
    }

    // MARK: - tv show

    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        guard let tvShow = localDataSource.getTVShow(id: tvShowId) else {
            completion(.failure(NSError(domain: "Cannot find tv show \(tvShowId)", code: 400, userInfo: nil)))
            return
        }
        
        guard let similarTVShow = tvShow.similar else {
            completion(.failure(NSError(domain: "tv show \(tvShowId) does not have similar", code: 400, userInfo: nil)))
            return
        }

        // get from cache
        if page <= similarTVShow.page {
            // get page less than or equal current page
            let fromTVShow = similarTVShow.totalResults / similarTVShow.totalPages * (page - 1)
            let toTVShow = similarTVShow.totalResults / similarTVShow.totalPages * page - 1
            let result = TVShowResult()
            result.onTV.append(objectsIn: similarTVShow.onTV[fromTVShow...toTVShow])
            completion(.success(result))
        } else if page != similarTVShow.page + 1 {
            // only consider next consecutive page
            completion(.failure(NSError(domain: "next page is not a consecutive of current page", code: 401, userInfo: nil)))
            return
        }
    }

    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        guard let tvShow = localDataSource.getTVShow(id: tvShowId) else {
            completion(.failure(NSError(domain: "Cannot find tv show \(tvShowId)", code: 400, userInfo: nil)))
            return
        }
        
        guard let recommendTVShow = tvShow.recommendations else {
            completion(.failure(NSError(domain: "tv show \(tvShowId) does not have recommendation", code: 400, userInfo: nil)))
            return
        }
        
        // get from cache
        if page <= recommendTVShow.page {
            // get page less than or equal current page
            let fromTVShow = recommendTVShow.totalResults / recommendTVShow.totalPages * (page - 1)
            let toTVShow = recommendTVShow.totalResults / recommendTVShow.totalPages * page - 1
            let result = TVShowResult()
            result.onTV.append(objectsIn: recommendTVShow.onTV[fromTVShow...toTVShow])
            completion(.success(result))
        } else if page != recommendTVShow.page + 1 {
            // only consider next consecutive page
            completion(.failure(NSError(domain: "next page is not a consecutive of current page", code: 401, userInfo: nil)))
            return
        }
    }

    func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void) {
        if
            let tvShow = localDataSource.getTVShow(id: tvShowId),
            tvShow.region == NSLocale.current.regionCode,
            tvShow.language == NSLocale.preferredLanguages.first {
            completion(.success(tvShow))
            return
        }

        services.getTVShowDetail(id: tvShowId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tvShow):
                    self.localDataSource.saveTVShow(tvShow)
                    completion(.success(tvShow))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        services.getPopularOnTV(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularTVShowResult):
                    completion(.success(popularTVShowResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowKeywords(from tvShowId: Int) -> [Keyword] {
        guard let keywords = localDataSource.getTVShow(id: tvShowId)?.keywords?.results else {
            return []
        }
        return Array(keywords)
    }

    // MARK: - trending

    func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        services.getTrending(time: time, type: type) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trendingResult):
                    completion(.success(trendingResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    // MARK: - people
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void) {
        services.getPopularPeople(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let popularPeopleResult):
                    completion(.success(popularPeopleResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void) {
        if
            let person = localDataSource.getPerson(id: id),
            person.region == NSLocale.current.regionCode,
            person.language == NSLocale.preferredLanguages.first {

            completion(.success(person))
            return
        }

        services.getPersonDetail(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let person):
                    self.localDataSource.savePerson(person)
                    completion(.success(person))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVCredits(from personId: Int) -> TVCredit? {
        return localDataSource.getPerson(id: personId)?.tvCredits
    }

    func getMovieCredits(from personId: Int) -> MovieCredit? {
        return localDataSource.getPerson(id: personId)?.movieCredits
    }

    func getPersonImageProfile(from personId: Int) -> ImageProfile? {
        return localDataSource.getPerson(id: personId)?.images
    }

    // MARK: - images
    func updateImageConfig() {
        if
            let lastUpdateDate = userSetting.imageConfig.dateUpdate,
            let daysBetweenDates = Calendar.current.dateComponents([.day], from: lastUpdateDate, to: Date()).day,
            daysBetweenDates < 10 { return }

        services.updateImageConfig { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let imageConfigResult):
                    self.userSetting.imageConfig = imageConfigResult
                }
            }
        }
    }

    // MARK: - search
    func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void) {
        services.multiSearch(query: query, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let multiSearchResult):
                    completion(.success(multiSearchResult))
                }
            }
        }
    }
}
