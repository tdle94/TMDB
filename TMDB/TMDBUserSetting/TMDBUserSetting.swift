//
//  UserDefault.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBUserSettingProtocol {
    var imageConfig: ImageConfigResult { get set }
    var userDefault: UserDefaults { get set }
    func getImageURL(from path: String) -> URL?
}

struct TMDBUserSetting: TMDBUserSettingProtocol {
    var userDefault: UserDefaults = UserDefaults.standard

    var imageConfig: ImageConfigResult {
        get {
            guard let data = userDefault.value(forKey: Constant.UserSetting.imageConfig) as? Data else {
                return ImageConfigResult() // return default
            }
            let imageConfig = try! PropertyListDecoder().decode(ImageConfigResult.self, from: data)
            return imageConfig
        }
        set {
            userDefault.set(try? PropertyListEncoder().encode(newValue), forKey: Constant.UserSetting.imageConfig)
        }
    }

    func getImageURL(from path: String) -> URL? {
        let base = imageConfig.images.secureBaseURL
        guard let size = imageConfig.images.posterSizes.last, let url = URL(string: "\(base)\(size)\(path)") else {
            return nil
        }
        return url
    }
}
