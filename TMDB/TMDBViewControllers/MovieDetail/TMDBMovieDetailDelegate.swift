//
//  TMDBMovieDetailDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBMovieDetailDelegate: NSObjectProtocol {
    func displayMovieDetail(_ movie: Movie)
    func displayMovieCasts(_ casts: [Cast])
    func displayMovieCrews(_ crews: [Crew])
    func displayMovies(_ movies: [Movie])
    func displayBackdropImage(_ images: [Images])
}
