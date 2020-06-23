//
//  TMDBServices+TMDBImageService.swift
//  TMDB
//
//  Created by Tuyen Le on 6/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import SDWebImage

extension TMDBServices: TMDBImageService {
    func getImageURL(from path: String) -> URL? {
        let base = userSetting.imageConfig.images.secureBaseURL
        guard let size = userSetting.imageConfig.images.posterSizes.last, let url = URL(string: "\(base)\(size)\(path)") else {
            return nil
        }
        return url
    }

    func updateImageConfig(completion: @escaping (Result<ImageConfigResult, Error>) -> Void) {
        let request = urlRequestBuilder.getImageConfigURLRequest()
        session.send(request: request, responseType: ImageConfigResult.self, completion: completion)
    }
}
