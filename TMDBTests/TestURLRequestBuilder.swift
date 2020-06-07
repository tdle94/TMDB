//
//  TestURLRequestBuilder.swift
//  TMDBTests
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

@testable import TMDB
import Quick
import Nimble
import Cuckoo

class TestURLRequestBuilder: XCTestCase {
    let urlRequestBuilder = URLRequestBuilder()

    // MARK: - popular
    func testPopularMovieURL() {
        let matchRequest = urlRequestBuilder.getPopularMovieURLRequest(page: 1)
        let urlMatcher = "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testPopularPeopleURL() {
        let matchRequest = urlRequestBuilder.getPopularPeopleURLRequest(page: 1)
        let urlMatcher = "https://api.themoviedb.org/3/person/popular?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testPopularOnTVURL() {
        let matchRequest = urlRequestBuilder.getPopularTVURLRequest(page: 1)
        let urlMatcher = "https://api.themoviedb.org/3/tv/popular?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    // MARK: - detail
    func testMovieDetailURL() {
        let matchRequest = urlRequestBuilder.getMovieDetailURLRequest(id: 3)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3?language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    // MARK: - trending
    func testTodayAllTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .all)
        let urlMatcher = "https://api.themoviedb.org/3/trending/all/today"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testTodayMovieTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .movie)
        let urlMatcher = "https://api.themoviedb.org/3/trending/movie/today"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testTodayPeopleTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .person)
        let urlMatcher = "https://api.themoviedb.org/3/trending/person/today"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testTodayTVTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .tv)
        let urlMatcher = "https://api.themoviedb.org/3/trending/tv/today"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekAllTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .all)
        let urlMatcher = "https://api.themoviedb.org/3/trending/all/week"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekMovieTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .all)
        let urlMatcher = "https://api.themoviedb.org/3/trending/all/week"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekPeopleTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .person)
        let urlMatcher = "https://api.themoviedb.org/3/trending/person/week"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekTVTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .tv)
        let urlMatcher = "https://api.themoviedb.org/3/trending/tv/week"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
}
