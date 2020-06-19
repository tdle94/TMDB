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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopularMovieDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(PopularMovie.self, from: popularMovieFixture))
    }
    
    func testPopularPeopleDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(PopularPeopleResult.self, from: popularPeopleFixture))
    }

    func testMovieDetailDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(Movie.self, from: movieDetailFixture))
    }

    func testPopularOnTVDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(PopularOnTVResult.self, from: popularOnTVFixture))
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
}
