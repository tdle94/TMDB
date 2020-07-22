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
        displayKeywords(tvShow: tvShow)
        displayNetworks(tvShow: tvShow)
        displaySeason(tvShow: tvShow)
        tvDetailVC?.title = tvShow.originalName
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

    private func displayKeywords(tvShow: TVShow) {
        tvDetailVC?.keywordCollectionView.reloadData()
        tvDetailVC?.keywordCollectionView.layoutIfNeeded()
        tvDetailVC?.keywordCollectionViewHeightConstraint.constant = tvDetailVC?.keywordCollectionView.contentSize.height ?? 0
    }

    private func displayOverview(tvShow: TVShow) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

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
        var runtime = Array(tvShow.episodeRunTime).map { $0 == tvShow.episodeRunTime.last || tvShow.episodeRunTime.count == 1 ? "\($0)" : "\($0), " }.joined()
        
        if runtime != "" {
            runtime = "\(runtime) mins \u{2022} \(tvShow.firstAirDate)"
        }
        tvDetailVC?.runtimeLabel.attributedText = NSAttributedString(string: runtime,
                                                                     attributes: [
                                                                        NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                    ])
    }

    private func displayStatusLabel(tvShow: TVShow) {
        tvDetailVC?.statusLabel.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ", subTitle: tvShow.status)
    }

    private func displayGenreLabel(tvShow: TVShow) {
        let genres = Array(tvShow.genres).map { tvShow.genres.count == 1 || tvShow.genres.last == $0 ? "\($0.name)" : "\($0.name), " }.joined()
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
