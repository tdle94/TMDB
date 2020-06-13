//
//  LocationManager.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import CoreLocation

class TMDBLocationManager: NSObject, CLLocationManagerDelegate {
    var manager: CLLocationManager = CLLocationManager()
    
    var locationService: TMDBLocationService

    var setting: TMDBUserSettingProtocol

    init(setting: TMDBUserSettingProtocol, locationService: TMDBLocationService) {
        self.setting = setting
        self.locationService = locationService
        super.init()
        manager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        locationService.geocode(location: location) { placemarks, error in
            guard error == nil else { return }

            self.setting.country = placemarks?.first?.isoCountryCode
            self.setting.language = Locale.current.languageCode
            self.setting.region = Locale.current.regionCode
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
