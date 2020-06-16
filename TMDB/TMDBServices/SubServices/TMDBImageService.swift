//
//  TMDBImageService.swift
//  TMDB
//
//  Created by Tuyen Le on 6/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBImageService {
    func getImageData(from url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
