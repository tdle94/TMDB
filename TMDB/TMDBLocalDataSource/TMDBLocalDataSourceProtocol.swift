//
//  TMDBLocalDataSource.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBLocalDataSourceProtocol {
    func getMovieDetail(id: Int) -> MovieDetail?
}
