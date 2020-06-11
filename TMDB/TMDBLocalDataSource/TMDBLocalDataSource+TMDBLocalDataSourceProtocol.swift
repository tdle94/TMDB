//
//  TMDBLocalDataSource+TMDBLocalDataSourceProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

struct TMDBLocalDataSource: TMDBLocalDataSourceProtocol {
    
    let realm = try! Realm()

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

    func getMovieDetail(id: Int) -> MovieDetail? {
        return realm.object(ofType: MovieDetail.self, forPrimaryKey: id)
    }
}
