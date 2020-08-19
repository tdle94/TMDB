//
//  TMDBTVDetailViewController+UITableViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = tvId else { return }
        if
            tableView == tvShowSeasonTableView,
            let seasonNumber = (tvShowSeasonDataSource.snapshot().itemIdentifiers(inSection: .season)[indexPath.row] as? Season)?.number {
            coordinate?.navigateToTVShowSeasonDetail(tvId: id, seasonNumber: seasonNumber)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
