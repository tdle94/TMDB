//
//  TMDBTVShowSeasonDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/21/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBTVShowSeasonDelegate: NSObjectProtocol {
    func displaySeason(season: Season)
    func displayBackdropImage(backdropImages: [Images])
    func displayError(_ error: Error)
}
