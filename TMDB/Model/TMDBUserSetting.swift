//
//  UserDefault.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct TMDBUserSetting: TMDBUserSettingProtocol {
    var language: String? {
        get {
            return UserDefaults.standard.object(forKey: Constant.UserSetting.language) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constant.UserSetting.language)
        }
    }
    
    var country: String? {
        get {
            return UserDefaults.standard.object(forKey: Constant.UserSetting.country) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constant.UserSetting.country)
        }
    }
    
    var region: String? {
        get {
            return UserDefaults.standard.object(forKey: Constant.UserSetting.region) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Constant.UserSetting.region)
        }
    }
}
