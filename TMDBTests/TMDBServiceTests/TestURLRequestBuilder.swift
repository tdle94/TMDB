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
    let urlRequestBuilder = TMDBURLRequestBuilder()

    // MARK: - people
    func testPopularPeopleURL() {
        let matchRequest = urlRequestBuilder.getPopularPeopleURLRequest(page: 1, language: nil)
        let urlMatcher = "https://api.themoviedb.org/3/person/popular?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    // MARK: - tv show
    func testPopularOnTVURL() {
        let matchRequest = urlRequestBuilder.getPopularTVURLRequest(page: 1, language: nil)
        let urlMatcher = "https://api.themoviedb.org/3/tv/popular?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    // MARK: - movie
    func testPopularMovieURL() {
        var matchRequest = urlRequestBuilder.getPopularMovieURLRequest(page: 1, language: nil, region: nil)
        var urlMatcher = "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&region=US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
        
        matchRequest = urlRequestBuilder.getPopularMovieURLRequest(page: 1, language: nil, region: "US")
        urlMatcher = "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&region=US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }

    func testMovieDetailURLWithDefaultLanguage() {
        let matchRequest = urlRequestBuilder.getMovieDetailURLRequest(id: 3, language: nil)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3?language=en-US&append_to_response=keywords,videos,similar,recommendations,credits,reviews&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testMovieDetailURLWithGermanLanguage() {
        let matchRequest = urlRequestBuilder.getMovieDetailURLRequest(id: 3, language: "de-US")
        let urlMatcher = "https://api.themoviedb.org/3/movie/3?language=de-US&append_to_response=keywords,videos,similar,recommendations,credits,reviews&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testSimilarMovieURLWithNilLanguage() {
        let matchRequest = urlRequestBuilder.getSimilarMoviesURLRequest(from: 3, page: 1, language: nil)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/similar?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testSimilarMovieURLWithEnglishLanguage() {
        let matchRequest = urlRequestBuilder.getSimilarMoviesURLRequest(from: 3, page: 1, language: "en-US")
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/similar?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testRecommendMovieURLWithDefaultLanguage() {
        let matchRequest = urlRequestBuilder.getRecommendMoviesURLRequest(from: 3, page: 1, language: nil)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/recommendations?page=1&language=en-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testRecommendMovieURLWithGermanLanguage() {
        let matchRequest = urlRequestBuilder.getRecommendMoviesURLRequest(from: 3, page: 1, language: "de-US")
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/recommendations?page=1&language=de-US&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testMovieCreditURL() {
        let matchRequest = urlRequestBuilder.getMovieCreditURLRequest(from: 3)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/credits?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }

    func testMovieReviewURL() {
        let matchRequest = urlRequestBuilder.getMovieReviewURLRequest(from: 3, page: 1)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/reviews?page=1&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }

    // MARK: - trending
    func testTodayAllTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .all)
        let urlMatcher = "https://api.themoviedb.org/3/trending/all/day?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testTodayMovieTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .movie)
        let urlMatcher = "https://api.themoviedb.org/3/trending/movie/day?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testTodayPeopleTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .person)
        let urlMatcher = "https://api.themoviedb.org/3/trending/person/day?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testTodayTVTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .today, type: .tv)
        let urlMatcher = "https://api.themoviedb.org/3/trending/tv/day?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekAllTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .all)
        let urlMatcher = "https://api.themoviedb.org/3/trending/all/week?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekMovieTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .all)
        let urlMatcher = "https://api.themoviedb.org/3/trending/all/week?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekPeopleTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .person)
        let urlMatcher = "https://api.themoviedb.org/3/trending/person/week?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testThisWeekTVTrendingURL() {
        let matchRequest = urlRequestBuilder.getTrendingURLRequest(time: .week, type: .tv)
        let urlMatcher = "https://api.themoviedb.org/3/trending/tv/week?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testMultiSearchURL() {
        let matchRequest = urlRequestBuilder.getMultiSearchURLRequest(query: "T", language: nil, region: nil)
        let urlMatcher = "https://api.themoviedb.org/3/search/multi?page=1&language=en-US&query=T&region=US&include_adult=true&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testPersonDetailURL() {
        let matchRequest = urlRequestBuilder.getPersonDetailURLRequest(id: 3, language: nil)
        let urlMatcher = "https://api.themoviedb.org/3/person/3?language=en-US&append_to_response=movie_credits,tv_credits,images&api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
    
    func testMovieImageURL() {
        let matchRequest = urlRequestBuilder.getMovieImages(from: 3)
        let urlMatcher = "https://api.themoviedb.org/3/movie/3/images?api_key=6823a37cea296ab67c0a2a6ce3cb4ec5"
        expect(matchRequest.url?.absoluteString).to(equal(urlMatcher))
    }
}
