//
//  Cast.swift
//  TMDB
//
//  Created by Tuyen Le on 27.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class CreditResult: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var cast: Cast?
    dynamic var crew: Crew?

    enum CodingKeys: String, CodingKey {
        case id, cast, crew
    }
}

@objcMembers
class Cast: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var character: String = ""
    dynamic var creditId: String = ""
    dynamic var castId: Int = 0
    dynamic var name: String = ""
    dynamic var order: Int = 0
    dynamic var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, character, name, order
        case creditId = "credit_id"
        case castId = "cast_id"
        case profilePath = "profile_path"
    }
}

@objcMembers
class Crew: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var department: String = ""
    dynamic var creditId: String = ""
    dynamic var job: String = ""
    dynamic var name: String = ""
    dynamic var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, department, job, name
        case creditId = "credit_id"
        case profilePath = "profile_path"
    }
}
