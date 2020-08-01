//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Foundation

struct TMDBRepository {
    let services: TMDBServices
    let localDataSource: TMDBLocalDataSourceProtocol
    static let share: TMDBRepository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                      urlRequestBuilder: TMDBURLRequestBuilder()),
                                               localDataSource: TMDBLocalDataSource())
    init(services: TMDBServices, localDataSource: TMDBLocalDataSourceProtocol) {
        self.services = services
        self.localDataSource = localDataSource
    }
}

extension TMDBRepository: TMDBPeopleRepository {
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
            person.language == NSLocale.current.languageCode {

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
}

extension TMDBRepository: TMDBSearchRepository {
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

extension TMDBRepository: TMDBTrendingRepository {
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
}

extension TMDBRepository: TMDBTVShowRepository {
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
        } else {
            services.getSimilarTVShows(from: tvShowId, page: page) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    case .success(let tvShowResult):
                        self.localDataSource.saveSimilarTVShow(tvShowResult.onTV, to: tvShowId)
                        completion(.success(tvShowResult))
                    }
                }
            }
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
        } else {
            services.getRecommendTVShows(from: tvShowId, page: page) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    case .success(let tvShowResult):
                        self.localDataSource.saveRecommendTVShow(tvShowResult.onTV, to: tvShowId)
                        completion(.success(tvShowResult))
                    }
                }
            }
        }
    }

    func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void) {
        if
            let tvShow = localDataSource.getTVShow(id: tvShowId),
            tvShow.region == NSLocale.current.regionCode,
            tvShow.language == NSLocale.current.languageCode {
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

    func getTVShowCast(from tvShowId: Int) -> [Cast] {
        guard let cast = localDataSource.getTVShow(id: tvShowId)?.credits?.cast else {
            return []
        }
        return Array(cast)
    }

    func getTVShowCrew(from tvShowId: Int) -> [Crew] {
        guard let crew = localDataSource.getTVShow(id: tvShowId)?.credits?.crew else {
            return []
        }
        return Array(crew)
    }

    func getTVShowReviews(from tvShowId: Int) -> [Review] {
        guard let reviews = localDataSource.getTVShow(id: tvShowId)?.reviews?.reviews else {
            return []
        }
        return Array(reviews)
    }

    func refreshTVShow(id: Int, completion: @escaping (Result<TVShow, Error>) -> Void) {
        services.getTVShowDetail(id: id) { result in
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
}

extension TMDBRepository: TMDBMovieRepository {
    func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults? {
        return localDataSource.getMovie(id: movieId)?.releaseDates
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
            movie.language == NSLocale.current.languageCode {

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
        } else if page != similarMovie.page + 1 {
            // only consider next consecutive page
            completion(.failure(NSError(domain: "next page is not a consecutive of current page", code: 401, userInfo: nil)))
        } else {
            // new page
            services.getSimilarMovies(from: movieId, page: page) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let similarMovieResult):
                        self.localDataSource.saveSimilarMovie(similarMovieResult.movies, to: movieId)
                        completion(.success(similarMovieResult))
                    case .failure(let error):
                        completion(.failure(error))
                    }
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
        } else if page != recommendMovie.page + 1 {
            // only consider next consecutive page
            completion(.failure(NSError(domain: "next page is not a consecutive of current page", code: 401, userInfo: nil)))
        } else {
            // new page
            services.getRecommendMovies(from: movieId, page: page) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let recommendMovieResult):
                        self.localDataSource.saveRecommendMovie(recommendMovieResult.movies, to: movieId)
                        completion(.success(recommendMovieResult))
                    case .failure(let error):
                        completion(.failure(error))
                    }
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

    func refreshMovie(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
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
}
