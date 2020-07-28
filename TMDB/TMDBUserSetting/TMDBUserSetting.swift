//
//  UserDefault.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBUserSettingProtocol {
    var imageConfig: ImageConfigResult { get }
    var userDefault: UserDefaults { get set }
    func getImageURL(from path: String) -> URL?
    func getYoutubeImageURL(key: String) -> URL?
    func getYoutubeVideoURL(key: String) -> URL?
}

struct TMDBUserSetting: TMDBUserSettingProtocol {
    var userDefault: UserDefaults = UserDefaults.standard

    var imageConfig: ImageConfigResult {
        return ImageConfigResult()
    }

    func getImageURL(from path: String) -> URL? {
        let base = imageConfig.images.secureBaseURL
        guard let size = imageConfig.images.posterSizes.last, let url = URL(string: "\(base)\(size)\(path)") else {
            return nil
        }
        return url
    }

    func getYoutubeImageURL(key: String) -> URL? {
        return URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }
    
    func getYoutubeVideoURL(key: String) -> URL? {
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
