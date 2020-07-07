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
        app.segmentedControls.buttons["TV Shows"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTapPopularPeople() {
        app.segmentedControls.buttons["People"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTapTrendingThisWeek() {
        app.segmentedControls.buttons["This Week"].tap()
        let expectations = expectation(description: "AsyncExpectations")
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTapPopularMovie() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5)
    }
    
//    func testTapPopularMoviePoster() {
//        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
//        let expectations = expectation(description: "AsyncExpectations")
//        collectionView.cells.firstMatch.tap()
//        expectations.fulfill()
//        waitForExpectations(timeout: 5, handler: nil)
//    }
}
