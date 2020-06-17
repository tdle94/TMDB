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
    // movie detail
    func getMovieDetail(id: Int) -> MovieDetail?
    func saveMovie(_ movie: MovieDetail) -> Bool
    // image config
    func getImageConfig() -> ImageConfigResult?
    func saveImageConfig(_ config: ImageConfigResult)
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

    func saveMovie(_ movie: MovieDetail) -> Bool {
        realm?.beginWrite()
        if let _ = realm?.object(ofType: MovieDetail.self, forPrimaryKey: movie.id) {
            realm?.cancelWrite()
            return false
        }
        realm?.add(movie)
        try? realm?.commitWrite()
        return true
    }

    func getImageConfig() -> ImageConfigResult? {
        return realm?.objects(ImageConfigResult.self).first
    }

    func saveImageConfig(_ config: ImageConfigResult) {
        realm?.beginWrite()
        config.dateUpdate = Date()
        realm?.add(config, update: .modified)
        try? realm?.commitWrite()
    }
}
