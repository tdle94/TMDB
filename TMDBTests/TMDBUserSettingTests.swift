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
    let locationService: MockTMDBLocationService = MockTMDBLocationService()
    let optional = ParameterMatcher<String?>()
    let userDefault: UserDefaults = UserDefaults(suiteName: #file)!

    override func setUp() {
        locationManager = TMDBLocationManager(setting: userSetting, locationService: locationService)

        /*GIVEN*/
        stub(userSetting) { stub in
            when(stub).country.set(optional).thenDoNothing()
            when(stub).language.set(optional).thenDoNothing()
            when(stub).region.set(optional).thenDoNothing()
            when(stub).userDefault.get.thenReturn(userDefault)
        }
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - test updated location

    // no error
    func testUserSettingCase1() {
        let locationMatcher = ParameterMatcher<CLLocation>()
        
        stub(locationService) { stub in
            when(stub).geocode(location: locationMatcher, completion: anyClosure()).then { implementation in
                let placemarks = CLPlacemark(location: implementation.0, name: "germany", postalAddress: CNPostalAddress())
                implementation.1([placemarks], nil)
            }
        }

        /*WHEN*/
        let locations = [CLLocation(latitude: 0, longitude: 0)]
        locationManager.locationManager(locationManager.manager, didUpdateLocations: locations)

        /*THEN*/
        verify(userSetting).country.set(optional)
        verify(userSetting).language.set(optional)
        verify(userSetting).region.set(optional)
        verify(locationService).geocode(location: locationMatcher, completion: anyClosure())
    }

    // with error
    func testUserSettingCase2() {
        let locationMatcher = ParameterMatcher<CLLocation>()
        
        stub(locationService) { stub in
            when(stub).geocode(location: locationMatcher, completion: anyClosure()).then { implementation in
                implementation.1(nil, NSError())
            }
        }

        /*WHEN*/
        let locations = [CLLocation(latitude: 0, longitude: 0)]
        locationManager.locationManager(locationManager.manager, didUpdateLocations: locations)

        /*THEN*/
        verify(locationService).geocode(location: locationMatcher, completion: anyClosure())
    }

    // with no location
    func testUserSettingCase3() {
        let locationMatcher = ParameterMatcher<CLLocation>()

        stub(locationService) { stub in
            when(stub).geocode(location: locationMatcher, completion: anyClosure()).then { implementation in
                implementation.1(nil, NSError())
            }
        }

        /*WHEN*/
        locationManager.locationManager(locationManager.manager, didUpdateLocations: [])
    }
    
    // MARK: - test user location setting
    func testUserLocationSetting() {
        var setting = TMDBUserSetting()
        setting.country = "US"
        setting.language = "en"
        setting.region = "US"
        
        XCTAssertNotNil(setting.country)
        XCTAssertEqual(setting.country, "US")
        
        XCTAssertNotNil(setting.language)
        XCTAssertEqual(setting.language, "en")
        
        XCTAssertNotNil(setting.region)
        XCTAssertEqual(setting.region, "US")
    }

    // MARK: - test image config
    func testImageConfig() {
        let imageConfigResult = ImageConfigResult()
        var setting = TMDBUserSetting(userDefault: userDefault)
        
        // return new image config
        setting.imageConfig = imageConfigResult
        XCTAssertEqual(setting.imageConfig.id, imageConfigResult.id)
    }
}
