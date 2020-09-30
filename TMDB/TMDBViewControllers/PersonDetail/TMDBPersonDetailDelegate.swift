//
//  TMDBPersonDetailDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBPersonDetailDelegate: NSObjectProtocol {
    func displayPerson(person: People)
    func displayMovieCredit(movies: [Movie])
    func displayTVShowCredit(tvShows: [TVShow])
    func displayError(_ error: Error)
}
