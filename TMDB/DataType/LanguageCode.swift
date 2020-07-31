//
//  LanguageCode.swift
//  TMDB
//
//  Created by Tuyen Le on 7/31/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct LanguageCode: Decodable {
    var iso6391: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name = "english_name"
    }
}
