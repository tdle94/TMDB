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
    
    // MARK: - people
    func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest

    // MARK: - trending
    func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest

    // MARK: - image configuration
    func getImageConfigURLRequest() -> URLRequest

    // MARK: - movies
    func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest
    func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest
    func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest
    func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest
    func getMovieCreditURLRequest(from movieId: Int) -> URLRequest
    func getMovieReviewURLRequest(from movieId: Int, page: Int) -> URLRequest
}

extension TMDBURLRequestBuilderProtocol {
    // MARK: - tv show

    func getPopularTVURLRequest(page: Int, language: String? = "en-US") -> URLRequest {
        return getPopularTVURLRequest(page: page, language: language)
    }

    // MARK: - peope

    func getPopularPeopleURLRequest(page: Int, language: String? = "en-US") -> URLRequest {
        return getPopularPeopleURLRequest(page: page, language: language)
    }
    
    // MARK: - movies
    func getMovieDetailURLRequest(id: Int, language: String? = "en-US") -> URLRequest {
        return getMovieDetailURLRequest(id: id, language: language)
    }

    func getPopularMovieURLRequest(page: Int, language: String? = "en-US", region: String? = nil) -> URLRequest {
        return getPopularMovieURLRequest(page: page, language: language, region: region)
    }

    func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String? = "en-US") -> URLRequest {
        return getSimilarMoviesURLRequest(from: movieId, page: page, language: language)
    }

    func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String? = "en-US") -> URLRequest {
        return getRecommendMoviesURLRequest(from: movieId, page: page, language: language)
    }
}

struct TMDBURLRequestBuilder: TMDBURLRequestBuilderProtocol {

    let apiKey = "6823a37cea296ab67c0a2a6ce3cb4ec5"

    // MARK: - tv shows

    func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language)
        ]
        return buildURLRequest(path: "/3/tv/popular", queryItems: queryItems)
    }

    // MARK: - peopel

    func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language)
        ]
        return buildURLRequest(path: "/3/person/popular", queryItems: queryItems)
    }

    // MARK: - trending
    func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest {
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
        return buildURLRequest(path: path, queryItems: nil)
    }

    private func buildURLRequest(path: String, queryItems: [URLQueryItem]?) -> URLRequest {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.themoviedb.org"
        urlComponent.path = path
        urlComponent.queryItems = queryItems ?? []
        urlComponent.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        return URLRequest(url: urlComponent.url!)
    }

    // MARK: - image config
    func getImageConfigURLRequest() -> URLRequest {
        return buildURLRequest(path: "/3/configuration", queryItems: nil)
    }

    // MARK: - movies

    func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        var queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language),
        ]
        if let region = region {
            queryItems.append(URLQueryItem(name: "region", value: region))
        }
        return buildURLRequest(path: "/3/movie/popular", queryItems: queryItems)
    }

    func getMovieDetailURLRequest(id: Int, language: String? = "en-US") -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "append_to_response", value: "videos")
        ]
        return buildURLRequest(path: "/3/movie/\(id)", queryItems: queryItems)
    }

    func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String? = "en-US") -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language)
        ]
        return buildURLRequest(path: "/3/movie/\(movieId)/similar", queryItems: queryItems)
    }

    func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String? = "en-US") -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language)
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
}
