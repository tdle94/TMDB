//
//  TMDBTableViewHeader.swift
//  TMDB
//
//  Created by Tuyen Le on 8/7/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum Section: String {
    case season
    case episode
    case popular
    case trending
    case productionCompanies
    case more
    case credit
    case video
    case keyword
    case image

    var header: String {
        switch self {
        case .season: return "Season"
        case .episode: return "Episode"
        case .popular: return "Popular"
        case .trending: return "Trends"
        case .productionCompanies: return "Production Companies"
        case .more: return "More"
        case .credit: return "Credit"
        case .video: return "Video"
        case .keyword: return "Keyword"
        case .image: return "Image"
        }
    }
}

class TMDBTableDataSource: UITableViewDiffableDataSource<Section, Object> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section].header
    }
}

class TMDBCollectionDataSource: UICollectionViewDiffableDataSource<Section, Object> {

}
