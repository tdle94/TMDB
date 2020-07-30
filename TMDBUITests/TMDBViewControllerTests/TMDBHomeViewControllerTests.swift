//
//  TMDBHomeViewControllerTests.swift
//  TMDBUITests
//
//  Created by Tuyen Le on 7/6/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import XCTest

class TMDBHomeViewControllerTests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testTapPopularTVShow() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons["TV Shows"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTapPopularPeople() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons["People"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTapPopularMovie() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        let expectations = expectation(description: "AsyncExpectations")
        let movieDetailScrollView = app.scrollViews.matching(identifier: "MovieDetailScrollView")
        let similarMovie = app.segmentedControls.buttons["Similar"]
        let cast = app.segmentedControls.buttons["Cast"]
        let crew = app.segmentedControls.buttons["Crew"]
        let recommendMovie = app.segmentedControls.buttons["Recommend"]
        app.segmentedControls.buttons["Movies"].tap()
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5)
        
        // cast and/or crew tap
        if cast.exists && crew.exists {
            while !cast.isHittable && !crew.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }
            cast.tap()
            crew.tap()
        } else if cast.exists {
            while !cast.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }
            cast.tap()
        } else {
            while !crew.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }
            crew.tap()
        }
        
        // similar and/or recommend movie tap
        if similarMovie.exists && recommendMovie.exists {
            while !similarMovie.isHittable && !recommendMovie.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }
            
            similarMovie.tap()
            recommendMovie.tap()
        } else if similarMovie.exists {
            while !similarMovie.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }

            similarMovie.tap()
        } else {
            while !recommendMovie.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }
            recommendMovie.tap()
        }
    }
    
    func testTapTrendingThisWeek() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons["This Week"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTapTrendingToday() {
         let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons["Today"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
