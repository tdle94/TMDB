//
//  URLRequestBuilder.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBURLRequestBuilderProtocol {
    // MARK: - tv shows
    func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest
    func getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest
    func getSimilarTVShowsURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest
    func getRecommendTVShowURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest
    func getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest
    func getTVShowImagesURLRequest(from tvShowId: Int) -> URLRequest
    func getTVShowEpisodeURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest
    func getTVShowSeasonImageURLRequest(from tvShowId: Int, seasonNumber: Int) -> URLRequest
    func getTVShowEpisodeImageURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest
    func getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest
    func getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest
    func getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest
    func getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest
    // MARK: - people
    func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest
    func getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest

    // MARK: - trending
    func getTrendingURLRequest(page: Int, time: TrendingTime, type: TrendingMediaType) -> URLRequest

    // MARK: - image configuration
    func getImageConfigURLRequest() -> URLRequest

    // MARK: - movies
    func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest
    func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest
    func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest
    func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest
    func getMovieCreditURLRequest(from movieId: Int) -> URLRequest
    func getMovieReviewURLRequest(from movieId: Int, page: Int) -> URLRequest
    func getMovieImagesURLRequest(from movieId: Int) -> URLRequest
    func getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest
    func getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest
    func getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest
    func getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest

    // MARK: - search
    func getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest

    // MARK: - authentication
    func getGuestSessionURLRequest() -> URLRequest

    // MARK: - rating
    func getPostMovieRatingURLRequest(movieId: Int, rate: Double) -> URLRequest
    func getPostTVShowRatingURLRequest(tvId: Int, rate: Double) -> URLRequest
}

struct TMDBURLRequestBuilder: TMDBURLRequestBuilderProtocol {

    let userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    // MARK: - tv shows

    func getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest {
        var queryItems = [
            URLQueryItem(name: "page", value: String(query.page))
        ]

        if let language = query.withOriginalLanguage {
            queryItems.append(URLQueryItem(name: "with_original_language", value: language))
        }

        if let genres = query.withGenres {
            queryItems.append(URLQueryItem(name: "with_genres", value: genres))
        }

        if let keyword = query.withKeyword {
            queryItems.append(URLQueryItem(name: "with_keywords", value: keyword))
        }
        
        if let primaryReleaseYear = query.primaryReleaseYear {
            queryItems.append(URLQueryItem(name: "primary_release_year", value: String(primaryReleaseYear)))
        }

        return buildURLRequest(path: "/3/discover/tv", queryItems: queryItems)
    }

    func getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
        ]
        return buildURLRequest(path: "/3/tv/top_rated", queryItems: queryItems)
    }

    func getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
        ]
        return buildURLRequest(path: "/3/tv/airing_today", queryItems: queryItems)
    }

    func getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
        ]
        return buildURLRequest(path: "/3/tv/on_the_air", queryItems: queryItems)
    }

    func getTVShowEpisodeImageURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest {
        buildURLRequest(path: "/3/tv/\(tvShowId)/season/\(seasonNumber)/episode/\(episodeNumber)/images", queryItems: nil)
    }

    func getTVShowSeasonImageURLRequest(from tvShowId: Int, seasonNumber: Int) -> URLRequest {
        return buildURLRequest(path: "/3/tv/\(tvShowId)/season/\(seasonNumber)/images", queryItems: nil)
    }

    func getTVShowEpisodeURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "append_to_response", value: "credits,videos")
        ]
        return buildURLRequest(path: "/3/tv/\(tvShowId)/season/\(seasonNumber)/episode/\(episodeNumber)", queryItems: queryItems)
    }

    func getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "append_to_response", value: "credits,videos")
        ]
        return buildURLRequest(path: "/3/tv/\(tvShowId)/season/\(seasonNumber)", queryItems: queryItems)
    }

    func getSimilarTVShowsURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en")
        ]
        return buildURLRequest(path: "/3/tv/\(tvShowId)/similar", queryItems: queryItems)
    }

    func getRecommendTVShowURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en")
        ]
        return buildURLRequest(path: "/3/tv/\(tvShowId)/recommendations", queryItems: queryItems)
    }

    func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en")
        ]
        return buildURLRequest(path: "/3/tv/popular", queryItems: queryItems)
    }

    func getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "append_to_response", value: "keywords,similar,recommendations,credits,reviews,videos")
        ]
        return buildURLRequest(path: "/3/tv/\(id)", queryItems: queryItems)
    }
    
    func getTVShowImagesURLRequest(from tvShowId: Int) -> URLRequest {
        return buildURLRequest(path: "/3/tv/\(tvShowId)/images", queryItems: nil)
    }

    // MARK: - peopele

    func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en")
        ]
        return buildURLRequest(path: "/3/person/popular", queryItems: queryItems)
    }
    
    func getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "append_to_response", value: "movie_credits,tv_credits,images")
        ]
        return buildURLRequest(path: "/3/person/\(id)", queryItems: queryItems)
    }

    // MARK: - trending
    func getTrendingURLRequest(page: Int, time: TrendingTime, type: TrendingMediaType) -> URLRequest {
        var path = "/3/trending/"
        switch type {
        case .all:
            path += "all/"
        case .movie:
            path += "movie/"
        case .person:
            path += "person/"
        case .tv:
            path += "tv/"
        }
        
        switch time {
        case .today:
            path += "day"
        case .week:
            path += "week"
        }

        let query = [
            URLQueryItem(name: "page", value: String(page))
        ]

        return buildURLRequest(path: path, queryItems: query)
    }

    private func buildURLRequest(path: String, queryItems: [URLQueryItem]?) -> URLRequest {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.themoviedb.org"
        urlComponent.path = path
        urlComponent.queryItems = queryItems ?? []
        urlComponent.queryItems?.append(URLQueryItem(name: "api_key", value: userSetting.apiKey))
        if let url = urlComponent.url {
            return URLRequest(url: url)
        }
        fatalError("Invalid url")
    }

    // MARK: - image config
    func getImageConfigURLRequest() -> URLRequest {
        return buildURLRequest(path: "/3/configuration", queryItems: nil)
    }

    // MARK: - movies

    func getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest {
        var queryItems = [
            URLQueryItem(name: "page", value: String(query.page)),
        ]

        if let keyword = query.withKeyword {
            queryItems.append(URLQueryItem(name: "with_keywords", value: keyword))
        }
        
        if let language = query.withOriginalLanguage {
            queryItems.append(URLQueryItem(name: "with_original_language", value: language))
        }
        
        if let genres = query.withGenres {
            queryItems.append(URLQueryItem(name: "with_genres", value: genres))
        }

        if let primaryReleaseYear = query.primaryReleaseYear {
            queryItems.append(URLQueryItem(name: "primary_release_year", value: String(primaryReleaseYear)))
        }

        return buildURLRequest(path: "/3/discover/movie", queryItems: queryItems)
    }

    func getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "region", value: region ?? "US")
        ]
        return buildURLRequest(path: "/3/movie/upcoming", queryItems: queryItems)
    }

    func getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "region", value: region ?? "US")
        ]
        return buildURLRequest(path: "/3/movie/top_rated", queryItems: queryItems)
    }
    
    func getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "region", value: region ?? "US")
        ]
        return buildURLRequest(path: "/3/movie/now_playing", queryItems: queryItems)
    }

    func getMovieImagesURLRequest(from movieId: Int) -> URLRequest {
        return buildURLRequest(path: "/3/movie/\(movieId)/images", queryItems: nil)
    }

    func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "region", value: region ?? "US")
        ]
        return buildURLRequest(path: "/3/movie/popular", queryItems: queryItems)
    }

    func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "append_to_response", value: "keywords,videos,similar,recommendations,credits,reviews,release_dates")
        ]
        return buildURLRequest(path: "/3/movie/\(id)", queryItems: queryItems)
    }

    func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en")
        ]
        return buildURLRequest(path: "/3/movie/\(movieId)/similar", queryItems: queryItems)
    }

    func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en")
        ]
        return buildURLRequest(path: "/3/movie/\(movieId)/recommendations", queryItems: queryItems)
    }

    func getMovieCreditURLRequest(from movieId: Int) -> URLRequest {
        return buildURLRequest(path: "/3/movie/\(movieId)/credits", queryItems: nil)
    }

    func getMovieReviewURLRequest(from movieId: Int, page: Int) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
        ]
        return buildURLRequest(path: "/3/movie/\(movieId)/reviews", queryItems: queryItems)
    }

    // MARK: - search
    func getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int = 1) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language ?? "en"),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "region", value: region ?? "US"),
            URLQueryItem(name: "include_adult", value: String(false))
        ]
        return buildURLRequest(path: "/3/search/multi", queryItems: queryItems)
    }

    // MARK: - authentication
    func getGuestSessionURLRequest() -> URLRequest {
        return buildURLRequest(path: "/3/authentication/guest_session/new", queryItems: nil)
    }

    // MARK: - rating
    func getPostMovieRatingURLRequest(movieId: Int, rate: Double) -> URLRequest {
        let data = try! JSONSerialization.data(withJSONObject: ["value": rate], options: .fragmentsAllowed)
        var request = buildURLRequest(path: "/3/movie/\(movieId)/rating", queryItems: [URLQueryItem(name: "guest_session_id", value: userSetting.guestSession?.id)])
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        request.httpMethod = "POST"
        return request
    }

    func getPostTVShowRatingURLRequest(tvId: Int, rate: Double) -> URLRequest {
        let data = try! JSONSerialization.data(withJSONObject: ["value": rate], options: .fragmentsAllowed)
        var request = buildURLRequest(path: "/3/tv/\(tvId)/rating", queryItems: [URLQueryItem(name: "guest_session_id", value: userSetting.guestSession?.id)])
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        request.httpMethod = "POST"
        return request
    }
}
