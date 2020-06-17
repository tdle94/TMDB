//
//  TMDBServices+TMDBImageService.swift
//  TMDB
//
//  Created by Tuyen Le on 6/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBImageService {
    func getImageData(from url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185\(url)") else {
            completion(.failure(TMDBSession.APIError.invalidURL))
            return
        }
        session.send(url: url, completion: completion)
    }
}
