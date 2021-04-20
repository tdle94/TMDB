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
    var guestSession: GuestSession? { get set }
    var apiKey: String { get }
    func getImageURL(from path: String?) -> URL?
    func getYoutubeImageURL(key: String) -> URL?
    func getYoutubeVideoURL(key: String) -> URL?
}

struct TMDBUserSetting: TMDBUserSettingProtocol {
    
    var userDefault: UserDefaults = UserDefaults.standard
    
    var apiKey: String {
        return "6823a37cea296ab67c0a2a6ce3cb4ec5"
    }

    var guestSession: GuestSession? {
        get {
            guard let decodedData = userDefault.data(forKey: "guest_session") else {
                return nil
            }
            
            do {
                return try JSONDecoder().decode(GuestSession.self, from: decodedData)
            } catch let error {
                debugPrint("Cannot retrieve guest session: \(error.localizedDescription)")
            }
            return nil
        }
        set {
            do {
                if let value = newValue {
                    let encodedData = try JSONEncoder().encode(value)
                    userDefault.set(encodedData, forKey: "guest_session")
                }
            } catch let error {
                debugPrint("Cannot save guest session: \(error.localizedDescription)")
            }
        }
    }

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

    func getImageURL(from path: String?) -> URL? {
        let base = imageConfig.images.secureBaseURL
        guard let path = path, path.isNotEmpty, let size = imageConfig.images.posterSizes.last, let url = URL(string: "\(base)\(size)\(path)") else {
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
