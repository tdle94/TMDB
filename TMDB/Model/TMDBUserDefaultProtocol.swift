//
//  UserDefault.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

protocol UserSettingProtocol {
    var language: String? { get set }
    var region: String? { get set }
}
