//
//  AuthenticationService.swift
//  TMDB
//
//  Created by Tuyen Le on 9/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol AuthenticationService {
    func getGuestSession(apiKey: String)
}
