//
//  TMDBService+TMDBPeopleService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBPeopleService {
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void) {
        let request = urlRequestBuilder.getPopularPeopleURLRequest(page: page, language: NSLocale.preferredLanguages.first)
        session.send(request: request, responseType: PeopleResult.self, completion: completion)
    }
}
