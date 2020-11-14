//
//  Video.swift
//  TMDB
//
//  Created by Tuyen Le on 6/30/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class VideoResult: Object, Decodable {
    let videos: List<Video> = List()

    enum CodingKeys: String, CodingKey {
        case videos = "results"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        videos.append(objectsIn: try container.decode(List<Video>.self, forKey: .videos))
    }

    required override init() {
        super.init()
    }
}

@objcMembers
class Video: Object, Decodable {
    dynamic var id: String = ""
    dynamic var iso6391: String = ""
    dynamic var iso31661: String = ""
    dynamic var key: String = ""
    dynamic var name: String = ""
    dynamic var site: String = ""
    dynamic var size: Int = 0
    dynamic var type: String = ""

    enum CodingKeys: String, CodingKey {
        case id, key, name, site, size, type
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
