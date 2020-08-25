//
//  TMDBMovieFilterViewController+UICollectionViewDelegateFlowLayout.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBMovieFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let label = UILabel()
        label.text = collectionView == genreCollectionView ? setting.movieGenres[indexPath.row].name : setting.languagesCode[indexPath.row].name
        label.sizeToFit()
        return CGSize(width: label.intrinsicContentSize.width, height: 30)
    }
}
