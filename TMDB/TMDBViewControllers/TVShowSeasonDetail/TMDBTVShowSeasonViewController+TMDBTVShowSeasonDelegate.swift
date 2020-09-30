//
//  TMDBTVShowSeasonViewController+TMDBTVShowSeasonDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/21/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVShowSeasonViewController: TMDBTVShowSeasonDelegate {
    func displaySeason(season: Season) {
        loadingView.removeFromSuperview()
        title = season.name
        presenter.getTVShowSeasonImage(tvId: tvId!, seasonNumber: seasonNumber!)
        displayPosterImage(season)
        displaySeasonName(season)
        displayAirDateLabel(season)
        displayOverview(season)
        displaySeasonEpisode(season)
        displaySeasonVideo(season)
        displaySeasonCredit(season)
    }

    func displayBackdropImage(backdropImages: [Images]) {
        var snapshot = posterImageDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .backdrop))
        snapshot.appendItems(backdropImages)
        posterImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - display subviews
    
    func displaySeasonVideo(_ season: Season) {
        var snapshot = videoDataSource.snapshot()
        
        guard let videos = season.videos?.videos, !videos.isEmpty else {
            snapshot.deleteSections([.video])
            videoDataSource.apply(snapshot, animatingDifferences: true)
            videoCollectionViewHeightConstraint.constant = 0
            return
        }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .video))
        snapshot.appendItems(Array(videos))
        videoDataSource.apply(snapshot, animatingDifferences: true)
        videoCollectionViewHeightConstraint.constant = videoCollectionView.contentSize.height/2
    }

    func displaySeasonCredit(_ season: Season) {
        var snapshot = creditDataSource.snapshot()
        guard
            let casts = season.credits?.cast,
            !casts.isEmpty
            else {
                snapshot.deleteSections([.credit])
                creditDataSource.apply(snapshot, animatingDifferences: true)
                creditCollectionViewHeightConstraint.constant = 0
                return
            }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(Array(casts))
        creditDataSource.apply(snapshot, animatingDifferences: true)
        creditCollectionViewHeightConstraint.constant = creditCollectionView.contentSize.height
    }

    func displaySeasonEpisode(_ season: Season) {
        var snapshot = episodeDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .episode))
        snapshot.appendItems(Array(season.episodes))
        episodeDataSource.apply(snapshot, animatingDifferences: true)
        episodeTableViewHeightConstraint.constant = episodeTableView.contentSize.height
    }

    func displayPosterImage(_ season: Season) {
        guard
            let path = season.posterPath,
            let url = userSetting.getImageURL(from: path) else { return }

        posterImageView.sd_setImage(with: url)
    }

    func displaySeasonName(_ season: Season) {
        seasonNameLabel.attributedText = NSAttributedString(string: season.name,
                                                            attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    func displayAirDateLabel(_ season: Season) {
        let airDate: String
        if season.airDate == nil || season.airDate == "" {
            airDate = "\(season.episodeCount) episodes"
        } else {
            airDate = "\(season.episodeCount) episodes \u{2022} \(season.airDate!)"
        }
        airDateLabel.attributedText = NSAttributedString(string: airDate,
                                                         attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    func displayOverview(_ season: Season) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        if season.overview == "" {
            overviewLabel.isHidden = true
            videoCollectionViewTopConstraint.constant = -50
            return
        }
        overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                          attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                           size: UIFont.labelFontSize)!])
        overviewDetailLabel.attributedText = NSAttributedString(string: season.overview,
                                                                attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                             NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
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

    func displayError(_ error: Error) {
        loadingView.showError(true)
    }
}
