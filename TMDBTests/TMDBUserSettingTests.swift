//
//  TMDBUserSettingTests.swift
//  TMDBTests
//
//  Created by Tuyen Le on 13.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

@testable import TMDB
import XCTest
import Cuckoo
import CoreLocation
import Intents
import Contacts

class TMDBUserSettingTests: XCTestCase {

    let userSetting: MockTMDBUserSettingProtocol = MockTMDBUserSettingProtocol()
    let userDefault: UserDefaults = UserDefaults(suiteName: #file)!

    override func setUp() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - test user location setting
    func testUserLocationSetting() {
        var setting = TMDBUserSetting(userDefault: userDefault)
        setting.language = nil
        setting.region = nil

        XCTAssertNotNil(setting.language)
        XCTAssertNotNil(setting.region)
        
        setting.language = "en"
        setting.region = "US"
        
        XCTAssertEqual(setting.language, "en")
        XCTAssertEqual(setting.region, "US")
    }

    // MARK: - test image config
    func testImageConfig() {
        let imageConfigResult = ImageConfigResult()
        var setting = TMDBUserSetting(userDefault: userDefault)
        // return default one
        XCTAssertEqual(setting.imageConfig.id, imageConfigResult.id)
        // return new image config
        setting.imageConfig = imageConfigResult
        XCTAssertEqual(setting.imageConfig.id, imageConfigResult.id)
    }
}
