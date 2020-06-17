//
//  Session.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol TMDBSessionProtocol {
    // this is for other request that require decoding
    func send<T: Decodable>(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    // this is for getting image
    func send(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

struct TMDBSession: TMDBSessionProtocol {

    enum APIError: Error {
        case noURLReponse
        case noData
        case cannotDecode
        case invalidURL
    }

    let session: TMDBURLSessionProtocol

    func send<T: Decodable>(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = session.tmdbDataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(APIError.noURLReponse))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let responseValueType = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseValueType))
            } catch let error {
                debugPrint(error)
                completion(.failure(APIError.cannotDecode))
            }
        }
        task.tmdbResume()
    }

    func send(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.tmdbDataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(APIError.noURLReponse))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            completion(.success(data))
        }
        task.tmdbResume()
    }
}
