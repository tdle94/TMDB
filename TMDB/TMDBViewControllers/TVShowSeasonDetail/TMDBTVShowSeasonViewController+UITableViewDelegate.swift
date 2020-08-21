//
//  TMDBTVShowSeasonViewController+UITableViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/21/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVShowSeasonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let tvId = tvId,
            let episode = episodeDataSource.itemIdentifier(for: indexPath) as? Episode else { return }

        coordinate?.navigateToTVShowEpisodeDetail(tvId: tvId, seasonNumber: episode.seasonNumber, episodeNumber: episode.episodeNumber)
    }
}
