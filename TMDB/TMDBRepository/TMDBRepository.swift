//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Foundation
import RealmSwift

class TMDBRepository {
    let services: TMDBServices
    let localDataSource: TMDBLocalDataSourceProtocol
    var userSetting: TMDBUserSettingProtocol
    
    static let share: TMDBRepository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                      urlRequestBuilder: TMDBURLRequestBuilder()),
                                                      localDataSource: TMDBLocalDataSource(), userSetting: TMDBUserSetting())
    init(services: TMDBServices, localDataSource: TMDBLocalDataSourceProtocol, userSetting: TMDBUserSettingProtocol) {
        self.services = services
        self.localDataSource = localDataSource
        self.userSetting = userSetting
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

    func getTVCredits(from personId: Int) -> [TVShow] {
        return Array(localDataSource.getPerson(id: personId)?.tvCredits?.cast ?? List<TVShow>())
    }

    func getMovieCredits(from personId: Int) -> [Movie] {
        return Array(localDataSource.getPerson(id: personId)?.movieCredits?.cast ?? List<Movie>())
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
    func getTrending(page: Int, time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void) {
        services.getTrending(page: page, time: time, type: type) { result in
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
    func getAllTVShow(query: DiscoverQuery, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        services.getAllTVShow(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let allTVShowResult):
                    completion(.success(allTVShowResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTopRatedTVShow(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        services.getTopRatedTVShow(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let topRatedTVShowResult):
                    completion(.success(topRatedTVShowResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    func getTVShowAiringToday(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        services.getTVShowAiringToday(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tvShowAiringTodayResult):
                    completion(.success(tvShowAiringTodayResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowOnTheAir(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        services.getTVShowOnTheAir(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tvShowOnTheAirResult):
                    completion(.success(tvShowOnTheAirResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowEpisodeImage(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        if let imageResult = localDataSource.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)?.images {
            completion(.success(imageResult))
            return
        }

        services.getTVShowEpisodeImage(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageResult):
                    self.localDataSource.saveTVShowEpisodeImage(imageResult, to: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
                    completion(.success(imageResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowSeasonImage(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        if let imageResult = localDataSource.getTVShowSeason(tvShowId: tvShowId, seasonNumber: seasonNumber)?.images {
            DispatchQueue.main.async {
                completion(.success(imageResult))
            }
            return
        }

        services.getTVShowSeasonImage(from: tvShowId, seasonNumber: seasonNumber) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageResult):
                    self.localDataSource.saveTVShowSeasonImage(imageResult, to: tvShowId, seasonNumber: seasonNumber)
                    completion(.success(imageResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (Result<Episode, Error>) -> Void) {
        if
            let episode = localDataSource.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber),
            episode.credits != nil,
            episode.videos != nil
        {
            completion(.success(episode))
            return
        }

        services.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episode):
                    self.localDataSource.saveTVShowEpisode(tvShowId: tvShowId, seasonNumber: seasonNumber, episode: episode)
                    completion(.success(episode))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowSeasonDetail(from tvShowId: Int, seasonNumber: Int, completion: @escaping (Result<Season, Error>) -> Void) {
        if
            let season = localDataSource.getTVShowSeason(tvShowId: tvShowId, seasonNumber: seasonNumber),
            !season.episodes.isEmpty,
            season.credits != nil,
            season.videos != nil
        {
            DispatchQueue.main.async {
                completion(.success(season))
            }
            return
        }

        services.getTVShowSeasonDetail(from: tvShowId, seasonNumber: seasonNumber) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let season):
                    self.localDataSource.saveTVShowSeason(season, to: tvShowId)
                    completion(.success(season))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        guard let tvShow = localDataSource.getTVShow(id: tvShowId) else {
            completion(.failure(NSError(domain: "Cannot find tv show \(tvShowId)", code: 400, userInfo: nil)))
            return
        }
        
        guard let similarTVShow = tvShow.similar, !similarTVShow.onTV.isEmpty else {
            completion(.failure(NSError(domain: "tv show \(tvShowId) does not have similar", code: 400, userInfo: nil)))
            return
        }

        // get from cache
        if page <= similarTVShow.page {
            // get page less than or equal current page
            let from = 20 * (page - 1)
            let to = page == similarTVShow.page ? similarTVShow.onTV.count - 1 : (20 * page) - 1
            let result = TVShowResult()
            result.onTV.append(objectsIn: similarTVShow.onTV[from...to])
            result.totalResults = similarTVShow.onTV.count
            completion(.success(result))
        } else if page <= similarTVShow.totalPages {
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
        } else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "No more pages for \(tvShowId)", code: 400, userInfo: nil)))
            }
        }
    }

    func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void) {
        guard let tvShow = localDataSource.getTVShow(id: tvShowId) else {
            completion(.failure(NSError(domain: "Cannot find tv show \(tvShowId)", code: 400, userInfo: nil)))
            return
        }
        
        guard let recommendTVShow = tvShow.recommendations, !recommendTVShow.onTV.isEmpty else {
            completion(.failure(NSError(domain: "tv show \(tvShowId) does not have recommendation", code: 400, userInfo: nil)))
            return
        }
        
        // get from cache
        if page <= recommendTVShow.page {
            // get page less than or equal current page
            let from = 20 * (page - 1)
            let to = page == recommendTVShow.page ? recommendTVShow.onTV.count - 1 : (20 * page) - 1
            let result = TVShowResult()
            result.onTV.append(objectsIn: recommendTVShow.onTV[from...to])
            result.totalResults = recommendTVShow.onTV.count
            completion(.success(result))
        } else if page <= recommendTVShow.totalPages {
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
        } else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "No more pages for \(tvShowId)", code: 400, userInfo: nil)))
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

    func getTVShowImages(from tvShowId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        if let images = localDataSource.getTVShow(id: tvShowId)?.images {
            completion(.success(images))
            return
        }
        
        services.getTVShowImages(from: tvShowId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageResult):
                    self.localDataSource.saveTVShowImages(imageResult, to: tvShowId)
                    completion(.success(imageResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTVShowEpisodeCast(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Cast] {
        guard let casts = localDataSource.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)?.credits?.cast else {
            return []
        }
        return Array(casts)
    }

    func getTVShowEpisodeCrew(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Crew] {
        guard let crews = localDataSource.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)?.credits?.crew else {
            return []
        }
        return Array(crews)
    }

    func getTVShowEpisodeGuestStar(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Cast] {
        guard let guestStars  = localDataSource.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)?.guestStars else {
            return []
        }
        return Array(guestStars)
    }
    
    func getTVShowSeasons(from tvShowId: Int) -> [Season] {
        return Array(localDataSource.getTVShowSeasons(tvShowId: tvShowId))
    }
    
    func getTVShowSeasonCasts(from tvShowId: Int, seasonNumber: Int) -> [Cast] {
        return Array(localDataSource.getTVShowSeasonCasts(from: tvShowId, seasonNumber: seasonNumber))
    }

    func getTVShowSeasonCrews(from tvShowId: Int, seasonNumber: Int) -> [Crew] {
        return Array(localDataSource.getTVShowSeasonCrews(from: tvShowId, seasonNumber: seasonNumber))
    }
}

extension TMDBRepository: TMDBMovieRepository {
    func getAllMovie(query: DiscoverQuery, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        services.getAllMovie(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let allMovieResult):
                    completion(.success(allMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getUpcomingMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        services.getUpcomingMovie(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let upcomingMovieResult):
                    completion(.success(upcomingMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getTopRateMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        services.getTopRateMovie(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let topRateMovieResult):
                    completion(.success(topRateMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getNowPlayingMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        services.getNowPlayingMovie(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let nowPlayingMovieResult):
                    completion(.success(nowPlayingMovieResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func getMovieImages(from movieId: Int, completion: @escaping (Result<ImageResult, Error>) -> Void) {
        if let images = localDataSource.getMovie(id: movieId)?.images {
            completion(.success(images))
            return
        }
        
        services.getMovieImages(from: movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageResult):
                    self.localDataSource.saveMovieImages(imageResult, to: movieId)
                    completion(.success(imageResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

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
        guard let movie = localDataSource.getMovie(id: movieId) else {
            completion(.failure(NSError(domain: "Cannot find movie \(movieId)", code: 400, userInfo: nil)))
            return
        }
        
        guard let similarMovie = movie.similar, !similarMovie.movies.isEmpty else {
            completion(.failure(NSError(domain: "movie \(movieId) does not have similar", code: 400, userInfo: nil)))
            return
        }

        // get from cache
        if page <= similarMovie.page {
            let from = 20 * (page - 1)
            let to = page == similarMovie.page ? similarMovie.movies.count - 1 : (20 * page) - 1
            let result = MovieResult()
            result.movies.append(objectsIn: similarMovie.movies[from...to])
            result.totalResults = similarMovie.movies.count
            completion(.success(result))
        } else if page <= similarMovie.totalPages {
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
        } else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "No more pages for \(movieId)", code: 400, userInfo: nil)))
            }
        }
    }

    func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void) {
        guard let movie = localDataSource.getMovie(id: movieId) else {
            completion(.failure(NSError(domain: "Cannot find movie \(movieId)", code: 400, userInfo: nil)))
            return
        }

        guard let recommendMovie = movie.recommendations, !recommendMovie.movies.isEmpty else {
            completion(.failure(NSError(domain: "movie \(movieId) does not have recommendations", code: 400, userInfo: nil)))
            return
        }
        // get from cache
        if page <= recommendMovie.page {
            let from = 20 * (page - 1)
            let to = page == recommendMovie.page ? recommendMovie.movies.count - 1 : (20 * page) - 1
            let result = MovieResult()
            result.movies.append(objectsIn: recommendMovie.movies[from...to])
            result.totalResults = recommendMovie.movies.count
            completion(.success(result))
        } else if page <= recommendMovie.totalPages {
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
        } else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "No more pages for \(movieId)", code: 400, userInfo: nil)))
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

extension TMDBRepository: TMDBAuthenticationRepository {
    func getUTCDate(from date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: date)
    }
    
    func getCurrentUTCDate() -> Date? {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: date)
        return getUTCDate(from: utcTimeZoneStr)
    }

    func getGuestSession() {
        guard
            let guestSession = userSetting.guestSession,
            let sessionDate = getUTCDate(from: guestSession.expiration),
            let currentDate = getCurrentUTCDate(),
            sessionDate >= currentDate
            else {
                services.getGuestSession { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let guestSession):
                            if guestSession.success {
                                self.userSetting.guestSession = guestSession
                                debugPrint("Success getting guest session: \(guestSession.id)")
                            }
                        case .failure(let error):
                            debugPrint("Cannot get guest session: \(error.localizedDescription)")
                        }
                    }
                }
                return
            }
    }
}

extension TMDBRepository: TMDBRatingRepository {
    func postMovieRating(movieId: Int, rate: Double, completion: @escaping (Result<RatingResponse, Error>) -> Void) {
        services.postMovieRating(movieId: movieId, rate: rate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func postTVShowRating(tvId: Int, rate: Double, completion: @escaping (Result<RatingResponse, Error>) -> Void) {
        services.postTVShowRating(tvId: tvId, rate: rate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
