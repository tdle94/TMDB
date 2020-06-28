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
}
