//
//  TMDBMovieFilterDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 23.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBFilterDelegate: NSObjectProtocol {
    func filter(query: DiscoverQuery)
}
