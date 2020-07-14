//
//  TMDBPeopleService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBPeopleService {
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)
    func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)
}
