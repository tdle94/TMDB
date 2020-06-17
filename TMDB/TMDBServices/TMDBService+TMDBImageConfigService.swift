//
//  TMDBService+TMDBImageConfigService.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBImageConfigService {
    func updateImageConfig(completion: @escaping (Result<ImageConfigResult, Error>) -> Void) {
        let request = urlRequestBuilder.getImageConfigURLRequest()
        session.send(request: request, responseType: ImageConfigResult.self, completion: completion)
    }
}
