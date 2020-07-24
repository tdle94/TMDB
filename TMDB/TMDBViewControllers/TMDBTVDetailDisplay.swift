//
//  TMDBTVDetailDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 7/21/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTVDetailDisplay {
    weak var tvDetailVC: TMDBTVDetailViewController?

    let userSetting: TMDBUserSetting = TMDBUserSetting()

    func displayTVShowDetail(_ tvShow: TVShow) {
        displayPosterImageView(tvShow: tvShow)
        displayStatusLabel(tvShow: tvShow)
        displayTypeLabel(tvShow: tvShow)
        displayOriginalLanguageLabel(tvShow: tvShow)
        displayNumberOfSeason(tvShow: tvShow)
        displayNumberOfEpisode(tvShow: tvShow)
        displayGenreLabel(tvShow: tvShow)
        displayTitleLabel(tvShow: tvShow)
        displayRuntimeLabel(tvShow: tvShow)
        displayOverview(tvShow: tvShow)
        displayKeywords()
        displayNetworks(tvShow: tvShow)
        displaySeason(tvShow: tvShow)
        displayMoreTVShows(tvShow: tvShow)
        tvDetailVC?.title = tvShow.originalName
    }
    
    func displayMoreTVShows(tvShow: TVShow) {
        guard
            let similar = tvShow.similar,
            let recommend = tvShow.recommendations,
            var snapshot = tvDetailVC?.matchingTVShowDataSource.snapshot() else {
            return
        }
        
        if similar.onTV.isEmpty, !recommend.onTV.isEmpty {
            tvDetailVC?.addtionalHeaderView?.segmentControl.removeSegment(at: 0, animated: false)
            tvDetailVC?.addtionalHeaderView?.segmentControl.selectedSegmentIndex = 0
            tvDetailVC?.matchingTVShowCollectionView.collectionViewLayout.invalidateLayout()
            snapshot.appendItems(Array(recommend.onTV))
            tvDetailVC?.matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        } else if !similar.onTV.isEmpty, recommend.onTV.isEmpty {
            tvDetailVC?.addtionalHeaderView?.segmentControl.removeSegment(at: 1, animated: false)
            tvDetailVC?.matchingTVShowCollectionView.collectionViewLayout.invalidateLayout()
            snapshot.appendItems(Array(similar.onTV))
            tvDetailVC?.matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        } else if !similar.onTV.isEmpty, !recommend.onTV.isEmpty {
            displayTVShow(Array(similar.onTV))
        } else {
            snapshot.deleteSections([.Matching])
            tvDetailVC?.matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }

        tvDetailVC?.matchingTVShowCollectionViewHeightConstraint.constant = tvDetailVC?.matchingTVShowCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }
    
    func displayTVShow(_ tvShows: [TVShow]) {
        guard var snapshot = tvDetailVC?.matchingTVShowDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Matching))
        snapshot.appendItems(tvShows, toSection: .Matching)
        tvDetailVC?.matchingTVShowCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        tvDetailVC?.matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func displaySeason(tvShow: TVShow) {
        guard var snapshot = tvDetailVC?.tvShowSeasonDataSource.snapshot() else { return }
        snapshot.appendItems(Array(tvShow.seasons))
        tvDetailVC?.tvShowSeasonDataSource.apply(snapshot, animatingDifferences: true)
        tvDetailVC?.tvShowSeasonTableView.layoutIfNeeded()
        tvDetailVC?.tvShowSeaonTableViewHeightConstraint.constant = tvDetailVC?.tvShowSeasonTableView.contentSize.height ?? 0
    }

    private func displayNetworks(tvShow: TVShow) {
        guard var snapshot = tvDetailVC?.movieNetworkImageDataSource.snapshot() else { return }
        snapshot.appendItems(Array(tvShow.networks))
        tvDetailVC?.movieNetworkImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    private func displayKeywords() {
        tvDetailVC?.keywordCollectionView.reloadData()
        tvDetailVC?.keywordCollectionView.layoutIfNeeded()
        tvDetailVC?.keywordCollectionViewHeightConstraint.constant = tvDetailVC?.keywordCollectionView.contentSize.height ?? 0
    }

    private func displayOverview(tvShow: TVShow) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        if tvShow.overview == "" {
            tvDetailVC?.overviewLabel.isHidden = true
        }
        tvDetailVC?.overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                                             attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                              size: UIFont.labelFontSize)!])
        tvDetailVC?.overviewDetailLabel.attributedText = NSAttributedString(string: tvShow.overview,
                                                                              attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                       size: 14)!,
                                                                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                           NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    private func displayTitleLabel(tvShow: TVShow) {
        tvDetailVC?.titleLabel.attributedText = NSAttributedString(string: tvShow.originalName,
                                                                   attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    private func displayRuntimeLabel(tvShow: TVShow) {
        var runtimes = Array(tvShow.episodeRunTime).map { "\($0)" }.joined(separator: ", ")
        if runtimes != "" {
            runtimes = "\(runtimes) mins \u{2022} \(tvShow.firstAirDate)"
        }
        tvDetailVC?.runtimeLabel.attributedText = NSAttributedString(string: runtimes,
                                                                     attributes: [
                                                                        NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                    ])
    }

    private func displayStatusLabel(tvShow: TVShow) {
        tvDetailVC?.statusLabel.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ", subTitle: tvShow.status)
    }

    private func displayGenreLabel(tvShow: TVShow) {
        let genres = Array(tvShow.genres).map { "\($0.name)" }.joined(separator: ", ")
        tvDetailVC?.genresLabel.attributedText = NSAttributedString(string: genres,
                                                                    attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                     size: UIFont.smallSystemFontSize)!])
    }

    private func displayTypeLabel(tvShow: TVShow) {
        tvDetailVC?.typeLabel.attributedText = constructAttrsString(title: NSLocalizedString("Type", comment: "") + ": ", subTitle: tvShow.type)
    }

    private func displayOriginalLanguageLabel(tvShow: TVShow) {
        tvDetailVC?.originalLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ", subTitle: Constant.languageCode[tvShow.originalLanguage] ?? "")
    }

    private func displayNumberOfSeason(tvShow: TVShow) {
        tvDetailVC?.numberOfSeasonLabel.attributedText = constructAttrsString(title: NSLocalizedString("Number Of Season", comment: "") + ": ", subTitle: String(tvShow.numberOfSeasons))
    }

    private func displayNumberOfEpisode(tvShow: TVShow) {
        tvDetailVC?.numberOfEpisodeLabel.attributedText = constructAttrsString(title: NSLocalizedString("Number Of Episode", comment: "") + ": ", subTitle: String(tvShow.numberOfEpisodes))
    }

    private func displayPosterImageView(tvShow: TVShow) {
        guard
            let posterPath = tvShow.posterPath,
            let url = userSetting.getImageURL(from: posterPath)
            else { return }
        tvDetailVC?.posterImageView.sd_setImage(with: url)
    }

    func constructAttrsString(title: String, subTitle: String) -> NSMutableAttributedString {
        let firstString = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Circular-Black", size: UIFont.smallSystemFontSize)!,
        ])
        let secondString = NSMutableAttributedString(string: subTitle, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!,
        ])
        firstString.append(secondString)
        return firstString
    }
}
