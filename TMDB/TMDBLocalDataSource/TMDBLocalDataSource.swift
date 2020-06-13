//
//  TMDBLocalDataSource+TMDBLocalDataSourceProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

protocol TMDBLocalDataSourceProtocol {
    func getMovieDetail(id: Int) -> MovieDetail?
    func save(movie: MovieDetail) -> Bool
}

class TMDBLocalDataSource: TMDBLocalDataSourceProtocol {

    let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }

    convenience init() {
        self.init(realm: try? Realm())
    }

    func getMovieDetail(id: Int) -> MovieDetail? {
        return realm?.object(ofType: MovieDetail.self, forPrimaryKey: id)
    }

    func save(movie: MovieDetail) -> Bool {
        realm?.beginWrite()
        if let _ = realm?.object(ofType: MovieDetail.self, forPrimaryKey: movie.id) {
            realm?.cancelWrite()
            return false
        }
        realm?.add(movie)
        try? realm?.commitWrite()
        return true
    }
}
