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

    var locationManager: TMDBLocationManager!
    let userSetting: MockTMDBUserSettingProtocol = MockTMDBUserSettingProtocol()
    let userDefault: UserDefaults = UserDefaults(suiteName: #file)!

    override func setUp() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
        locationManager = TMDBLocationManager(setting: userSetting)
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - test updated location

    // no error
    func testUserSetting() {
        let optional = ParameterMatcher<String?>()
        /*GIVEN*/
        stub(userSetting) { stub in
            when(stub).country.set(optional).thenDoNothing()
            when(stub).language.set(optional).thenDoNothing()
            when(stub).region.set(optional).thenDoNothing()
            when(stub).country.get.thenReturn(nil)
            when(stub).language.get.thenReturn(nil)
            when(stub).region.get.thenReturn(nil)
            when(stub).userDefault.get.thenReturn(userDefault)
        }

        /*WHEN*/
        locationManager.localeChange()
        /*THEN*/
        verify(userSetting).country.set(any())
        verify(userSetting).language.set(any())
        verify(userSetting).region.set(any())
    }

    // MARK: - test user location setting
    func testUserLocationSetting() {
        var setting = TMDBUserSetting(userDefault: userDefault)
        setting.country = nil
        setting.language = nil
        setting.region = nil

        XCTAssertNotNil(setting.country)
        XCTAssertNotNil(setting.language)
        XCTAssertNotNil(setting.region)
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
