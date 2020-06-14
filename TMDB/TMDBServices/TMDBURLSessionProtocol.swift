//
//  URLSessionProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 14.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBURLSessionProtocol {
    func tmdbDataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol
}

extension URLSession: TMDBURLSessionProtocol {
    func tmdbDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler)
    }
}
