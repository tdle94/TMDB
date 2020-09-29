//
//  RatingResponse.swift
//  TMDB
//
//  Created by Tuyen Le on 9/27/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct RatingResponse: Decodable {
    let status: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status = "status_code"
        case message = "status_message"
    }
}
