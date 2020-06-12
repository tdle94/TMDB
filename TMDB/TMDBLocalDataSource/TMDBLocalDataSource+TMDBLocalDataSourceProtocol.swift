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

    func getMovieDetail(id: Int) -> MovieDetail? {
        return realm.object(ofType: MovieDetail.self, forPrimaryKey: id)
    }
}
