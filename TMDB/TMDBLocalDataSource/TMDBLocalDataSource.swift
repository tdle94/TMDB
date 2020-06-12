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
    func save(movie: MovieDetail) -> Error?
}

struct TMDBLocalDataSource: TMDBLocalDataSourceProtocol {

    let realm = try! Realm()

    func getMovieDetail(id: Int) -> MovieDetail? {
        return realm.object(ofType: MovieDetail.self, forPrimaryKey: id)
    }

    func save(movie: MovieDetail) -> Error? {
        do {
            try realm.write {
                realm.add(movie)
            }
        } catch let error {
            return error
        }
        return nil
    }
}
