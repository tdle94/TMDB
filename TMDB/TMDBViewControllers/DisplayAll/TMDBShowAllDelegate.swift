//
//  TMDBShowAllDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

protocol TMDBShowAllDelegate: NSObjectProtocol {
    func displayAll(objects: [Object])
}
