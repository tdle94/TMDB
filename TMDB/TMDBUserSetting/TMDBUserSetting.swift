//
//  UserDefault.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBUserSettingProtocol {
    var language: String? { get set }
    var country: String? { get set }
    var region: String? { get set }
    var imageConfig: ImageConfigResult { get set }
    var userDefault: UserDefaults { get set }
}

struct TMDBUserSetting: TMDBUserSettingProtocol {
    var userDefault: UserDefaults = UserDefaults.standard

    var language: String? {
        get {
            return userDefault.object(forKey: Constant.UserSetting.language) as? String ?? Locale.current.languageCode
        }
        set {
            userDefault.setValue(newValue, forKey: Constant.UserSetting.language)
        }
    }
    
    var country: String? {
        get {
            return userDefault.object(forKey: Constant.UserSetting.country) as? String ?? Locale.current.regionCode
        }
        set {
            userDefault.setValue(newValue, forKey: Constant.UserSetting.country)
        }
    }
    
    var region: String? {
        get {
            return userDefault.object(forKey: Constant.UserSetting.region) as? String ?? Locale.current.regionCode
        }
        set {
            userDefault.setValue(newValue, forKey: Constant.UserSetting.region)
        }
    }

    var imageConfig: ImageConfigResult {
        get {
            guard let data = UserDefaults.standard.value(forKey: Constant.UserSetting.imageConfig) as? Data else {
                return ImageConfigResult() // return default
            }
            let imageConfig = try! PropertyListDecoder().decode(ImageConfigResult.self, from: data)
            return imageConfig
        }
        set {
            userDefault.set(try? PropertyListEncoder().encode(newValue), forKey: Constant.UserSetting.imageConfig)
        }
    }
}
