//
//  TMDBDataType.swift
//  TMDBTests
//
//  Created by Tuyen Le on 12.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

@testable import TMDB
import XCTest

class TMDBDataTypeTests: XCTestCase {

    func testPopularMovieDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(MovieResult.self, from: popularMovieFixture))
    }
    
    func testPopularPeopleDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(PeopleResult.self, from: popularPeopleFixture))
    }
    
    func testPeopleDetailDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(People.self, from: peopleDetailFixture))
    }

    func testMovieDetailDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieDetailFixture))
        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieDetailFixture1))
    }

    func testPopularOnTVDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(TVShowResult.self, from: popularOnTVFixture))
    }

    func testTVShowDetail() {
        XCTAssertNoThrow(try JSONDecoder().decode(TVShow.self, from: tvShowDetailFixture))
    }
    
    func testTrendingMovieDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: trendingMovieTodayFixture))
    }

    func testTrendingOnTVDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: trendingOnTVTodayFixture))
    }
    
    func testTrendingPeopleDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: trendingPeopleTodayFixture))
    }
    
    func testAllTrendingToday() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: allTodayTrending))
    }
    
    func testAllTrendingThisWeek() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: allTrendingThisWeekFixture))
    }
    
    func testTrendingMovieThisWeek() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: trendingMovieThisWeekFixture))
    }
    
    func testTrendingOnTVThisWeek() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: trendingOnTVThisWeekFixture))
    }
    
    func testTrendingPeopleThisWeek() {
        XCTAssertNoThrow(try JSONDecoder().decode(TrendingResult.self, from: trendingPeopleThisWeekFixture))
    }

    func testMovieCredit() {
        XCTAssertNoThrow(try JSONDecoder().decode(CreditResult.self, from: movieCreditFixture))
    }

    func testMovieReview() {
        XCTAssertNoThrow(try JSONDecoder().decode(ReviewResult.self, from: movieReviewFixture))
    }

    func testMovieVideo() {
        XCTAssertNoThrow(try JSONDecoder().decode(VideoResult.self, from: movieVideoFixture))
    }

    func testMovieDetailWithKeywordVideoSimilarRecommendationCredit() {
        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieDetailFixtureWithVideoKeywordSimilarRecommendationCredit))
    }
    
    func testMoieDetailWithReview() {
        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieDetailFixtureWithReview))
    }
    
    func testMultiSearchFixture() {
        XCTAssertNoThrow(try JSONDecoder().decode(MultiSearchResult.self, from: multiSearchFixture))
    }
    
    func testPersonDetailFixture() {
        XCTAssertNoThrow(try JSONDecoder().decode(People.self, from: personDetailFixture))
    }
    
    func testMovieDetailWithCompleteReleaseDate() {
        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieDetailFixtureWithReleaseDates))
    }

    func testTVShowSesaonDetail() {
        XCTAssertNoThrow(try JSONDecoder().decode(Season.self, from: tvShowSeasonDetail))
    }
    
    func testTVShowEpisodeDetail() {
        XCTAssertNoThrow(try JSONDecoder().decode(Episode.self, from: tvShowEpisodeFixture))
    }
}
