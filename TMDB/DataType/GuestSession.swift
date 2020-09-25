//
//  GuestSession.swift
//  TMDB
//
//  Created by Tuyen Le on 9/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct GuestSession: Codable, Equatable {
    let success: Bool
    let id: String
    let expiration: String

    enum CodingKeys: String, CodingKey {
        case success
        case id = "guest_session_id"
        case expiration = "expires_at"
    }
}
