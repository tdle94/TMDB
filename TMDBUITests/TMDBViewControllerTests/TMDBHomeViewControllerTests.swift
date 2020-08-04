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
        let expectations = expectation(description: "AsyncExpectations")
        let tvShowDetailScrollView = app.scrollViews.matching(identifier: "TVShowDetailScrollView")
        let cast = app.segmentedControls.buttons[NSLocalizedString("Cast", comment: "")]
        let crew = app.segmentedControls.buttons[NSLocalizedString("Crew", comment: "")]
        let similarTVShow = app.segmentedControls.buttons[NSLocalizedString("Similar", comment: "")]
        let recommendTVShow = app.segmentedControls.buttons[NSLocalizedString("Recommend", comment: "")]
        let tvShowSeasonTableView = tvShowDetailScrollView.tables.firstMatch

        app.segmentedControls.buttons[NSLocalizedString("TV Shows", comment: "")].tap()
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
        
        // similar and/or recommend movie tap
        if similarTVShow.exists && recommendTVShow.exists {
            while !similarTVShow.isHittable && !recommendTVShow.isHittable {
                tvShowDetailScrollView.firstMatch.swipeUp()
            }
            
            similarTVShow.tap()
            recommendTVShow.tap()
        } else if similarTVShow.exists {
            while !similarTVShow.isHittable {
                tvShowDetailScrollView.firstMatch.swipeUp()
            }

            similarTVShow.tap()
        } else {
            while !recommendTVShow.isHittable {
                tvShowDetailScrollView.firstMatch.swipeUp()
            }
            recommendTVShow.tap()
        }
        
        // cast and/or crew tap
        if cast.exists && crew.exists {
            while !cast.isHittable && !crew.isHittable {
                tvShowDetailScrollView.firstMatch.swipeUp()
            }
            cast.tap()
            crew.tap()
        } else if cast.exists {
            while !cast.isHittable {
                tvShowDetailScrollView.firstMatch.swipeUp()
            }
            cast.tap()
        } else {
            while !crew.isHittable {
                tvShowDetailScrollView.firstMatch.swipeUp()
            }
            crew.tap()
        }

        // tap on tv show season
        if tvShowSeasonTableView.exists {
            while !tvShowSeasonTableView.isHittable {
                tvShowDetailScrollView.firstMatch.swipeDown()
            }
            tvShowSeasonTableView.cells.firstMatch.tap()
        }
    }
    
    func testTapPopularMovie() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        let expectations = expectation(description: "AsyncExpectations")
        let movieDetailScrollView = app.scrollViews.matching(identifier: "MovieDetailScrollView")
        let cast = app.segmentedControls.buttons[NSLocalizedString("Cast", comment: "")]
        let crew = app.segmentedControls.buttons[NSLocalizedString("Crew", comment: "")]
        let similarMovie = app.segmentedControls.buttons[NSLocalizedString("Similar", comment: "")]
        let recommendMovie = app.segmentedControls.buttons[NSLocalizedString("Recommend", comment: "")]
        app.segmentedControls.buttons[NSLocalizedString("Movies", comment: "")].tap()
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
        }
    }
    
    func testTapTrendingThisWeek() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons[NSLocalizedString("This Week", comment: "")].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTapTrendingToday() {
         let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons[NSLocalizedString("Today", comment: "")].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTapPopularPeople() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        app.segmentedControls.buttons[NSLocalizedString("People", comment: "")].tap()
        let expectations = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        expectations.fulfill()
        waitForExpectations(timeout: 5, handler: nil)
    }

}
