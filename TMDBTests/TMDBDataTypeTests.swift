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

    func testMovieDetailDecode() {
        XCTAssertNoThrow(try JSONDecoder().decode(MovieDetail.self, from: movieDetailFixture))
    }
}
