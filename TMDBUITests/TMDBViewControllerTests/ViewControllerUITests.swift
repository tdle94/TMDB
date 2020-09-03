//
//  TMDBHomeViewControllerTests.swift
//  TMDBUITests
//
//  Created by Tuyen Le on 7/6/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func tapPopularTVShow() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView")
        let expectations = expectation(description: "AsyncExpectations")
        let tvShowDetailScrollView = app.scrollViews.matching(identifier: "TVShowDetailScrollView")
        let cast = app.segmentedControls.buttons[NSLocalizedString("Cast", comment: "")]
        let crew = app.segmentedControls.buttons[NSLocalizedString("Crew", comment: "")]
        let similarTVShow = app.segmentedControls.buttons[NSLocalizedString("Similar", comment: "")]
        let recommendTVShow = app.segmentedControls.buttons[NSLocalizedString("Recommend", comment: "")]
        let tvShowSeasonTableView = tvShowDetailScrollView.tables.firstMatch
        let tvShowSeasonScrollView = app.scrollViews.matching(identifier: "TVShowSeasonDetailScrollView")
        let tvShowEpisodeTableView = tvShowSeasonScrollView.tables.firstMatch

        app.segmentedControls.buttons[NSLocalizedString("TV Shows", comment: "")].tap()
        collectionView.cells.firstMatch.tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        collectionView.cells.element(boundBy: 1).tap()
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

        // tap on tv show episode
        if tvShowEpisodeTableView.exists {
            while !tvShowEpisodeTableView.isHittable {
                tvShowSeasonScrollView.firstMatch.swipeUp()
            }
            tvShowEpisodeTableView.cells.firstMatch.tap()
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
        app.navigationBars.buttons.element(boundBy: 0).tap()
        collectionView.cells.element(boundBy: 1).tap()
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
            app.collectionViews.element(boundBy: 1).cells.firstMatch.tap()
            app.navigationBars.buttons.element(boundBy: 0).tap()
            recommendMovie.tap()
            app.collectionViews.element(boundBy: 1).cells.firstMatch.tap()
            app.navigationBars.buttons.element(boundBy: 0).tap()
        } else if similarMovie.exists {
            while !similarMovie.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }

            similarMovie.tap()
            app.collectionViews.element(boundBy: 1).cells.firstMatch.tap()
            app.navigationBars.buttons.element(boundBy: 0).tap()
        } else if recommendMovie.exists {
            while !recommendMovie.isHittable {
                movieDetailScrollView.firstMatch.swipeUp()
            }
            recommendMovie.tap()
            app.collectionViews.element(boundBy: 1).cells.firstMatch.tap()
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }

        app.navigationBars.buttons.element(boundBy: 0).tap()

        tapPopularTVShow()

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()

        tapTrendingThisWeek()

        app.tabBars.buttons[NSLocalizedString("Movies", comment: "")].tap()
        // tap on filter
        app.navigationBars.children(matching: .button).firstMatch.tap()
        // go back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        // tap on filter
        app.navigationBars.children(matching: .button).firstMatch.tap()
        // tap on done
        app.navigationBars.children(matching: .button)[NSLocalizedString("Done", comment: "")].tap()
        
        app.tabBars.buttons[NSLocalizedString("TV Shows", comment: "")].tap()
        // tap on filter
        app.navigationBars.children(matching: .button).firstMatch.tap()
        // go back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        // tap on filter
        app.navigationBars.children(matching: .button).firstMatch.tap()
        // tap on done
        app.navigationBars.children(matching: .button)[NSLocalizedString("Done", comment: "")].tap()

        app.tabBars.buttons[NSLocalizedString("Search", comment: "")].tap()
    }

    func tapTrendingThisWeek() {
        let collectionView = app.collectionViews.matching(identifier: "HomeCollectionView").firstMatch

        // tap popular people
        app.segmentedControls.buttons[NSLocalizedString("People", comment: "")].tap()
        let expectations2 = expectation(description: "AsyncExpectations")
        collectionView.cells.firstMatch.tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        collectionView.cells.element(boundBy: 1).tap()
        expectations2.fulfill()
        waitForExpectations(timeout: 5, handler: nil)

        app.scrollViews.firstMatch.swipeUp()
        app.scrollViews.firstMatch.swipeUp()

        // tap appear in movie button

        if app.segmentedControls.buttons[NSLocalizedString("Movies", comment: "")].exists {
            app.segmentedControls.buttons[NSLocalizedString("Movies", comment: "")].tap()
        }

        if app.segmentedControls.buttons[NSLocalizedString("TV Shows", comment: "")].exists {
            app.segmentedControls.buttons[NSLocalizedString("TV Shows", comment: "")].tap()
        }

        app.navigationBars.buttons.element(boundBy: 0).tap()

        // tap trending this week
        app.segmentedControls.buttons[NSLocalizedString("This Week", comment: "")].tap()

        // tap trending today
        app.segmentedControls.buttons[NSLocalizedString("Today", comment: "")].tap()

        collectionView.firstMatch.swipeUp()

        // tap now playing movie button
        app.segmentedControls.buttons[NSLocalizedString("Now Playing", comment: "")].tap()

        // tap top rate movie button
        app.segmentedControls.buttons[NSLocalizedString("Top Rated", comment: "")].tap()

        // tap upcoming movie button
        app.segmentedControls.buttons[NSLocalizedString("Upcoming", comment: "")].tap()

        collectionView.firstMatch.swipeUp()

        // tap air today tv show
        app.segmentedControls.buttons[NSLocalizedString("Air Today", comment: "")].tap()

        // tap top rated tv show
        app.segmentedControls.buttons[NSLocalizedString("Top Rated", comment: "")].tap()

        // tap on the air tv show
        app.segmentedControls.buttons[NSLocalizedString("On The Air", comment: "")].tap()
    }
}
