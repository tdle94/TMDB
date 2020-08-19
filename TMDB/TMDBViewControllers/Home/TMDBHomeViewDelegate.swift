//
//  TMDBHomeViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/17/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBHomeViewDelegate: NSObjectProtocol {
    func displayMovies(_ movies: [Movie], type: TMDBHomePresenter.Popular)
    func displayTVShows(_ tvShows: [TVShow], type: TMDBHomePresenter.Popular)
    func displayPeople(_ people: [People])
    func displayTrends(_ trends: [Trending])
}
