//
//  TMDBImageConfigService.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBImageConfigService {
    func updateImageConfig(completion: @escaping (Result<ImageConfigResult, Error>) -> Void)
}
