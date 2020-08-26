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
    var countriesCode: [CountryCode] { get }
    var languagesCode: [LanguageCode] { get }
    var movieGenres: [Genre] { get }
    var tvShowGenres: [Genre] { get }
    func getImageURL(from path: String) -> URL?
    func getYoutubeImageURL(key: String) -> URL?
    func getYoutubeVideoURL(key: String) -> URL?
}

struct TMDBUserSetting: TMDBUserSettingProtocol {
    
    var userDefault: UserDefaults = UserDefaults.standard

    var imageConfig: ImageConfigResult {
        return ImageConfigResult()
    }

    var countriesCode: [CountryCode] {
        let path = Bundle.main.path(forResource: "CountryCode", ofType: "json")!
        let jsonData = try! NSData(contentsOfFile: path, options: .dataReadingMapped)
        return try! JSONDecoder().decode([CountryCode].self, from: jsonData as Data)
    }

    var languagesCode: [LanguageCode] {
        let path = Bundle.main.path(forResource: "LanguageCode", ofType: "json")!
        let jsonData = try! NSData(contentsOfFile: path, options: .dataReadingMapped)
        return try! JSONDecoder().decode([LanguageCode].self, from: jsonData as Data)
    }

    var movieGenres: [Genre] {
        let path = Bundle.main.path(forResource: "MovieGenres", ofType: "json")!
        let jsonData = try! NSData(contentsOfFile: path, options: .dataReadingMapped)
        return try! JSONDecoder().decode(GenreResult.self, from: jsonData as Data).genres
    }

    var tvShowGenres: [Genre] {
        let path = Bundle.main.path(forResource: "TVShowGenres", ofType: "json")!
        let jsonData = try! NSData(contentsOfFile: path, options: .dataReadingMapped)
        return try! JSONDecoder().decode(GenreResult.self, from: jsonData as Data).genres
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
