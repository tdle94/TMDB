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
    let cast: List<Cast> = List()
    let crew: List<Crew> = List()

    enum CodingKeys: String, CodingKey {
        case cast, crew
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast.append(objectsIn: try container.decode(List<Cast>.self, forKey: .cast))
        crew.append(objectsIn: try container.decode(List<Crew>.self, forKey: .crew))
    }

    required init() {
        super.init()
    }
}

@objcMembers
class Cast: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var character: String = ""
    dynamic var creditId: String = ""
    dynamic var name: String = ""
    dynamic var order: Int = 0
    dynamic var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, character, name, order
        case creditId = "credit_id"
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
