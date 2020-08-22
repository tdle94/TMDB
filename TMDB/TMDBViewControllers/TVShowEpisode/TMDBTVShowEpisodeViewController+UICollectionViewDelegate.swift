//
//  TMDBTVShowEpisodeViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVShowEpisodeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = creditDataSource.itemIdentifier(for: indexPath)
        if collectionView == creditCollectionView, let id = (object as? Cast)?.id ?? (object as? Crew)?.id {
            coordinate?.navigateToPersonDetail(id: id)
        }
    }
}
