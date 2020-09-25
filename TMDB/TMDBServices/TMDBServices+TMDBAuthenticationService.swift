//
//  TMDBServices+AuthenticationService.swift
//  TMDB
//
//  Created by Tuyen Le on 9/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBAuthenticationService {
    func getGuestSession(completion: @escaping (Result<GuestSession, Error>) -> Void) {
        let request = urlRequestBuilder.getGuestSessionURLRequest()
        session.send(request: request, responseType: GuestSession.self, completion: completion)
    }
}
