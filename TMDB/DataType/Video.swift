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

    required init() {
        super.init()
    }
}

@objcMembers
class Video: Object, Decodable {
    dynamic var id: String = ""
    dynamic var iso_639_1: String = ""
    dynamic var iso_3166_1: String = ""
    dynamic var key: String = ""
    dynamic var name: String = ""
    dynamic var site: String = ""
    dynamic var size: Int = 0
    dynamic var type: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
