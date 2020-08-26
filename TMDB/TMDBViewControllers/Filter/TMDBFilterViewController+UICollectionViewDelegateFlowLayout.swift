//
//  TMDBMovieFilterViewController+UICollectionViewDelegateFlowLayout.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let label = UILabel()
        if genreCollectionView == collectionView {
            if filterChoice == .movie {
                label.text = setting.movieGenres[indexPath.row].name
            } else {
                label.text = setting.tvShowGenres[indexPath.row].name
            }
        } else if languageCollectionView == collectionView {
            label.text = setting.languagesCode[indexPath.row].name
        } else {
            label.text = String(years[indexPath.row])
        }
        label.sizeToFit()
        return CGSize(width: label.intrinsicContentSize.width, height: 30)
    }
}
