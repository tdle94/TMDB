//
//  TMDBTVShowSeasonDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 02.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTVShowSeasonDisplay {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    weak var tvShowSeasonVC: TMDBTVShowSeasonViewController?

    func displaySeason(_ season: Season) {
        tvShowSeasonVC?.title = season.name
        displayPosterImage(season)
        displaySeasonName(season)
        displayAirDateLabel(season)
        displayOverview(season)
        displaySeasonEpisode(season)
        displaySeasonVideo(season)
        displaySeasonCredit(season)
    }

    func displaySeasonVideo(_ season: Season) {
        guard
            let videos = season.videos?.videos,
            var snapshot = tvShowSeasonVC?.videoDataSource.snapshot() else { return }
        
        if videos.isEmpty {
            snapshot.deleteSections([.Video])
            tvShowSeasonVC?.videoDataSource.apply(snapshot, animatingDifferences: true)
            tvShowSeasonVC?.videoCollectionViewHeightConstraint.constant = 0
            return
        }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Video))
        snapshot.appendItems(Array(videos))
        tvShowSeasonVC?.videoDataSource.apply(snapshot, animatingDifferences: true)
        tvShowSeasonVC?.videoCollectionViewHeightConstraint.constant = (tvShowSeasonVC?.videoCollectionView.contentSize.height ?? 0)/2
    }

    func displaySeasonCredit(_ season: Season) {
        guard var snapshot = tvShowSeasonVC?.creditDataSource.snapshot() else { return }
        guard
            let casts = season.credits?.cast,
            !casts.isEmpty
            else {
                snapshot.deleteSections([.Credit])
                tvShowSeasonVC?.creditDataSource.apply(snapshot, animatingDifferences: true)
                return
            }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Credit))
        snapshot.appendItems(Array(casts))
        tvShowSeasonVC?.creditDataSource.apply(snapshot, animatingDifferences: true)
        tvShowSeasonVC?.creditCollectionViewHeightConstraint.constant = tvShowSeasonVC?.creditCollectionView.contentSize.height ?? 0
    }

    func displaySeasonEpisode(_ season: Season) {
        guard var snapshot = tvShowSeasonVC?.episodeDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Episode))
        snapshot.appendItems(Array(season.episodes))
        tvShowSeasonVC?.episodeDataSource.apply(snapshot, animatingDifferences: true)
        tvShowSeasonVC?.episodeTableViewHeightConstraint.constant = tvShowSeasonVC?.episodeTableView.contentSize.height ?? 0
    }

    func displayPosterImage(_ season: Season) {
        guard
            let path = season.posterPath,
            let url = userSetting.getImageURL(from: path) else { return }

        tvShowSeasonVC?.posterImageView.sd_setImage(with: url)
    }

    func displaySeasonName(_ season: Season) {
        tvShowSeasonVC?.seasonNameLabel.attributedText = NSAttributedString(string: season.name,
                                                                            attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    func displayAirDateLabel(_ season: Season) {
        tvShowSeasonVC?.airDateLabel.attributedText = NSAttributedString(string: "\(season.episodeCount) episodes \u{2022} \(season.airDate ?? "")",
                                                                         attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    func displayOverview(_ season: Season) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        if season.overview == "" {
            tvShowSeasonVC?.overviewLabel.isHidden = true
            tvShowSeasonVC?.videoCollectionViewTopConstraint.constant = -50
            return
        }
        tvShowSeasonVC?.overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                                             attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                              size: UIFont.labelFontSize)!])
        tvShowSeasonVC?.overviewDetailLabel.attributedText = NSAttributedString(string: season.overview,
                                                                              attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                       size: 14)!,
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
}
