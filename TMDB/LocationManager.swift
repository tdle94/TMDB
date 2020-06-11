//
//  LocationManager.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    var manager: CLLocationManager = CLLocationManager()
    
    var geodecoder: CLGeocoder = CLGeocoder()
    
    var setting: TMDBUserSettingProtocol = TMDBUserSetting()

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        geodecoder.reverseGeocodeLocation(location) { placemarks, error in
            guard
                error == nil,
                let countryCode = placemarks?.first?.isoCountryCode else { return }

            self.setting.country = countryCode
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
