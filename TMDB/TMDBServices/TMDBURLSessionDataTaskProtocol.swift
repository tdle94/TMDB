//
//  URLSessionDataTaskProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 14.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBURLSessionDataTaskProtocol {
    func tmdbResume()
}

extension URLSessionDataTask: TMDBURLSessionDataTaskProtocol {
    func tmdbResume() {
        resume()
    }
}
