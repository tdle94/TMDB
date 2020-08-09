//
//  TMDBCellConfig.swift
//  TMDB
//
//  Created by Tuyen Le on 09.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

protocol TMDBCellConfig {
    func configure(item: Object)
}
