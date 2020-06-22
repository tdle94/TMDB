//
//  TMDBServices+TMDBTVService.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBServices: TMDBTVService {
    func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void) {
        let language: String? = userSetting.language != nil && userSetting.region != nil ? "\(userSetting.language!)-\(userSetting.region!)" : nil
        let request = urlRequestBuilder.getPopularTVURLRequest(page: page, language: language)
        session.send(request: request, responseType: PopularOnTVResult.self, completion: completion)
    }
}
