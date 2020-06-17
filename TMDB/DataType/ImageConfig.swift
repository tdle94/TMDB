//
//  ImageConfig.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class ImageConfigResult: Object, Codable {
    dynamic var images: ImageConfig
    dynamic var changeKeys: List<String> = List<String>()
    dynamic var dateUpdate: Date?
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

@objcMembers
class ImageConfig: Object, Codable {
    dynamic var baseURL: String = ""
    dynamic var secureBaseURL: String = ""
    dynamic var backdropSizes: List<String> = List<String>()
    dynamic var logoSizes: List<String> = List<String>()
    dynamic var posterSizes: List<String> = List<String>()
    dynamic var profileSizes: List<String> = List<String>()
    dynamic var stillSizes: List<String> = List<String>()

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
