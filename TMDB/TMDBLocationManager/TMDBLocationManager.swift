//
//  LocationManager.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import CoreLocation

class TMDBLocationManager {

    var setting: TMDBUserSettingProtocol

    init(setting: TMDBUserSettingProtocol) {
        self.setting = setting
        NotificationCenter.default.addObserver(self, selector: #selector(localeChange), name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }

    @objc func localeChange() {
        self.setting.language = Locale.current.languageCode
        self.setting.region = Locale.current.regionCode
    }
}
