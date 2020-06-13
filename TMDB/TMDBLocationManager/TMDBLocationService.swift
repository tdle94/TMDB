//
//  LocationService.swift
//  TMDB
//
//  Created by Tuyen Le on 13.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import CoreLocation

protocol TMDBLocationService {
    func geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void)
}

struct TMDBGeocoder: TMDBLocationService {
    let geodecoder: CLGeocoder = CLGeocoder()

    func geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void) {
        geodecoder.reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks, error)
        }
    }
}
