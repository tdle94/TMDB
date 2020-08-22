//
//  TMDBTVShowDetailDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBTVShowDetailDelegate: NSObjectProtocol {
    func displayTVShowDetail(tvShow: TVShow)
    func displayTVShows(tvShows: [TVShow])
    func displayCasts(casts: [Cast])
    func displayCrews(crews: [Crew])
    func displayBackdropImage(images: [Images])
}
