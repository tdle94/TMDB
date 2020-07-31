//
//  LanguageCode.swift
//  TMDB
//
//  Created by Tuyen Le on 7/31/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct LanguageCode: Decodable {
    let iso31661: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "english_name"
    }
}
