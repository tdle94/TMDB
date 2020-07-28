//
//  TMDBPeopleRepsoitory.swift
//  TMDB
//
//  Created by Tuyen Le on 27.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBPeopleRepository {
    func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)
    func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)
    func getTVCredits(from personId: Int) -> TVCredit?
    func getMovieCredits(from personId: Int) -> MovieCredit?
    func getPersonImageProfile(from personId: Int) -> ImageProfile?
}
