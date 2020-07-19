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
    var setting: TMDBUserSettingProtocol!

    override func setUp() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
        setting = TMDBUserSetting(userDefault: userDefault)
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - test image config
    func testGetImageURL() {
        let imageConfigResult = ImageConfigResult()
        // return default one
        XCTAssertEqual(setting.imageConfig.id, imageConfigResult.id)
        // return new image config
        setting.imageConfig = imageConfigResult
        XCTAssertEqual(setting.imageConfig.id, imageConfigResult.id)
        XCTAssertNotNil(setting.getImageURL(from: "/owefijoweifj.png"))
        XCTAssertNil(setting.getImageURL(from: "\\\\\\"))
    }

    func testGetYoutubeImageURL() {
        XCTAssertNotNil(setting.getYoutubeImageURL(key: "key"))
    }

    func testGetYoutubeVideoURL() {
        XCTAssertNotNil(setting.getYoutubeVideoURL(key: "key"))
    }
}
