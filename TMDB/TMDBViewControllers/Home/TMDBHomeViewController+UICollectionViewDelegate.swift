//
//  TMDBHomeViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/17/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension TMDBHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: Object
        if indexPath.section == 0 {
            item = dataSource.snapshot().itemIdentifiers(inSection: .popular)[indexPath.row]
        } else if indexPath.section == 1 {
            item = dataSource.snapshot().itemIdentifiers(inSection: .trending)[indexPath.row]
        } else if indexPath.section == 2 {
            item = dataSource.snapshot().itemIdentifiers(inSection: .movie)[indexPath.row]
        } else {
            item = dataSource.snapshot().itemIdentifiers(inSection: .tvShow)[indexPath.row]
        }

        if let item = item as? Movie ?? (item as? Trending)?.movie {
            coordinate?.navigateToMovieDetail(id: item.id)
        } else if let item = item as? People ?? (item as? Trending)?.people {
            coordinate?.navigateToPersonDetail(id: item.id)
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            coordinate?.navigateToTVShowDetail(tvId: item.id)
        }
    }
}
