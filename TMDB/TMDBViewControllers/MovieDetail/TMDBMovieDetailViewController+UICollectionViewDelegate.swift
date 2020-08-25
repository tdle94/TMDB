//
//  TMDBMovieDetailViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

// MARK: - preview poster user interaction
extension TMDBMovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if
            collectionView == matchingMoviesCollectionView,
            let movie = matchingMoviesDataSource.itemIdentifier(for: indexPath) as? Movie
        {
            coordinator?.navigateToMovieDetail(id: movie.id)
        }

        if
            collectionView == videoCollectionView,
            let video = videoMovieDataSource.itemIdentifier(for: indexPath) as? Video,
            let url = TMDBUserSetting().getYoutubeVideoURL(key: video.key)
        {
            coordinator?.navigateToVideoPlayer(with: url)
        }

        if
            collectionView == creditCollectionView,
            let id = (creditMovieDataSource.snapshot().itemIdentifiers[indexPath.row] as? Cast)?.id ?? (creditMovieDataSource.snapshot().itemIdentifiers[indexPath.row] as? Crew)?.id
        {
            coordinator?.navigateToPersonDetail(id: id)
        }

        if
            collectionView == keywordCollectionView,
            let id = movieId
        {
            let keyword = presenter.repository.getMovieKeywords(from: id)
            coordinator?.navigateToAllMovie(query: DiscoverQuery(page: 1, withKeyword: String(keyword[indexPath.row].id)))
        }
    }
}
