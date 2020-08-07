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

    var header: String {
        switch self {
        case .season: return "Season"
        case .episode: return "Episode"
        }
    }
}

class TMDBTableDataSource: UITableViewDiffableDataSource<Section, Object> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section].header
    }
}
