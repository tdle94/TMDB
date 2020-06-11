//
//  URLRequestBuilder.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBURLRequestBuilderProtocol {
    // MARK: - popular

    func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest
    func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest
    func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest

    // MARK: - trending

    func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest

    // MARK: - detail

    func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest
}

extension TMDBURLRequestBuilderProtocol {
    // MARK: - popular

    func getPopularMovieURLRequest(page: Int, language: String? = "en-US", region: String? = nil) -> URLRequest {
        return getPopularMovieURLRequest(page: page, language: language, region: region)
    }

    func getPopularTVURLRequest(page: Int, language: String? = "en-US") -> URLRequest {
        return getPopularTVURLRequest(page: page, language: language)
    }

    func getPopularPeopleURLRequest(page: Int, language: String? = "en-US") -> URLRequest {
        return getPopularPeopleURLRequest(page: page, language: language)
    }

    // MARK: - trending

    func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest {
        return getTrendingURLRequest(time: time, type: type)
    }

    // MARK: - detail

    func getMovieDetailURLRequest(id: Int, language: String? = "en-US") -> URLRequest {
        return getMovieDetailURLRequest(id: id, language: language)
    }
}

struct TMDBURLRequestBuilder: TMDBURLRequestBuilderProtocol {

    let apiKey = "6823a37cea296ab67c0a2a6ce3cb4ec5"

    // MARK: - popular

    func getPopularMovieURLRequest(page: Int, language: String? = "en-US", region: String? = nil) -> URLRequest {
        var queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language),
        ]
        if let region = region {
            queryItems.append(URLQueryItem(name: "region", value: region))
        }
        return buildURLRequest(path: "/3/movie/popular", queryItems: queryItems)
    }
    
    func getPopularTVURLRequest(page: Int, language: String? = "en-US") -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: language)
        ]
        return buildURLRequest(path: "/3/tv/popular", queryItems: queryItems)
    }
    
    func getPopularPeopleURLRequest(page: Int, language: String? = "en-US") -> URLRequest {
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
            path += "today"
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
        urlComponent.queryItems = queryItems
        urlComponent.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        return URLRequest(url: urlComponent.url!)
    }
    
    // MARK: - detail
    func getMovieDetailURLRequest(id: Int, language: String? = "en-US") -> URLRequest {
        let queryItems = [
            URLQueryItem(name: "language", value: language)
        ]
        return buildURLRequest(path: "/3/movie/\(id)", queryItems: queryItems)
    }
}
