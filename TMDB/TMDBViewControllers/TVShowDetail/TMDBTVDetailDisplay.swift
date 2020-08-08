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
        displayCredit(tvShow: tvShow)
        displayAvailableLanguageLabel(tvShow: tvShow)
        displayReviewLabel(tvShow: tvShow)
        displayVideos(tvShow: tvShow)
        displayCreator(tvShow: tvShow)
        tvDetailVC?.title = tvShow.originalName
    }

    func displayBackdropImages(_ imageResult: ImageResult) {
        guard var snapshot = tvDetailVC?.tvShowBackdropImageDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .backdrop))
        snapshot.appendItems(Array(imageResult.backdrops))
        tvDetailVC?.tvShowBackdropImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCreator(tvShow: TVShow) {
        guard var snapshot = tvDetailVC?.tvShowCreatorDataSrouce.snapshot() else { return }
        guard !tvShow.createdBy.isEmpty else {
            snapshot.deleteSections([.creator])
            tvDetailVC?.tvShowCreatorDataSrouce.apply(snapshot, animatingDifferences: true)
            tvDetailVC?.creatorCollectionViewHeightConstraint.constant = 0
            return
        }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .creator))
        snapshot.appendItems(Array(tvShow.createdBy))
        tvDetailVC?.tvShowCreatorDataSrouce.apply(snapshot, animatingDifferences: true)
        tvDetailVC?.creatorCollectionViewHeightConstraint.constant = (tvDetailVC?.creatorCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0)/1.1
    }

    func displayVideos(tvShow: TVShow) {
        guard var snapshot = tvDetailVC?.tvShowVideoDataSource.snapshot() else { return }
        guard let videos = tvShow.videos?.videos, !videos.isEmpty else {
            snapshot.deleteSections([.video])
            tvDetailVC?.tvShowVideoDataSource.apply(snapshot, animatingDifferences: true)
            tvDetailVC?.videoCollectionViewHeightConstraint.constant = 0
            return
        }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .video))
        snapshot.appendItems(Array(videos))
        tvDetailVC?.tvShowVideoDataSource.apply(snapshot, animatingDifferences: true)
        tvDetailVC?.videoCollectionViewHeightConstraint.constant = (tvDetailVC?.videoCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0)/2
    }

    func displayReviewLabel(tvShow: TVShow) {
        tvDetailVC?.reviewButton.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Review", comment: "") + " (\(tvShow.reviews?.totalResults ?? 0))",
                                                                       attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!]),
                                                    for: .normal)
    }

    func displayAvailableLanguageLabel(tvShow: TVShow) {
        let languagesCode = userSetting.languagesCode
        var languages: [String] = []

        for languageCode in tvShow.languages {
            if let language = languagesCode.first(where: { $0.iso6391 == languageCode })?.name {
                languages.append(language)
            }
        }
        
        if languages.joined(separator: ", ") != "" {
            tvDetailVC?.availableLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Available Languages", comment: "") + ": ", subTitle: languages.joined(separator: ", "))
        }
    }
    
    func displayCredit(tvShow: TVShow) {
        guard
            let crew = tvShow.credits?.crew,
            let cast = tvShow.credits?.cast,
            var snapshot = tvDetailVC?.tvShowCreditDataSource.snapshot() else { return }
        tvDetailVC?.creditHeaderView?.segmentControl.removeAllSegments()
        if !cast.isEmpty {
            tvDetailVC?.creditHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
        }
        
        if !crew.isEmpty {
            tvDetailVC?.creditHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Crew", comment: ""), at: 1, animated: true)
        }
        
        if tvDetailVC?.creditHeaderView?.segmentControl.numberOfSegments == 2 || crew.isEmpty {
            displayCast(Array(cast), reloadSection: false)
        } else if tvDetailVC?.creditHeaderView?.segmentControl.numberOfSegments == 1 {
            displayCrew(Array(crew), reloadSection: false)
        } else {
            snapshot.deleteSections([.credit])
            tvDetailVC?.tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
        }
        
        tvDetailVC?.creditHeaderView?.segmentControl.selectedSegmentIndex = 0
        tvDetailVC?.tvShowCreditCollectionView.collectionViewLayout.invalidateLayout()
        tvDetailVC?.tvShowCreditCollectionViewHeightConstraint.constant = tvDetailVC?.tvShowCreditCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }
    
    func displayCast(_ casts: [Cast], reloadSection: Bool = true) {
        guard var snapshot = tvDetailVC?.tvShowCreditDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts)
        tvDetailVC?.tvShowCreditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: false)
        if casts.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        tvDetailVC?.tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrew(_ crews: [Crew], reloadSection: Bool = true) {
        guard var snapshot = tvDetailVC?.tvShowCreditDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews)
        tvDetailVC?.tvShowCreditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: false)
        if crews.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        tvDetailVC?.tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayMoreTVShows(tvShow: TVShow) {
        guard
            let similar = tvShow.similar,
            let recommend = tvShow.recommendations,
            var snapshot = tvDetailVC?.matchingTVShowDataSource.snapshot() else {
            return
        }
        tvDetailVC?.addtionalHeaderView?.segmentControl.removeAllSegments()
        if !similar.onTV.isEmpty {
            tvDetailVC?.addtionalHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Similar", comment: ""), at: 0, animated: true)
        }

        if !recommend.onTV.isEmpty {
            tvDetailVC?.addtionalHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Recommend", comment: ""), at: 1, animated: true)
        }
        
        if tvDetailVC?.addtionalHeaderView?.segmentControl.numberOfSegments == 2 || recommend.onTV.isEmpty {
            displayTVShow(Array(similar.onTV))
        } else if tvDetailVC?.addtionalHeaderView?.segmentControl.numberOfSegments == 1 {
            displayTVShow(Array(recommend.onTV))
        } else {
            snapshot.deleteSections([.matching])
            tvDetailVC?.matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }
        tvDetailVC?.addtionalHeaderView?.segmentControl.selectedSegmentIndex = 0
        tvDetailVC?.matchingTVShowCollectionView.collectionViewLayout.invalidateLayout()
        tvDetailVC?.matchingTVShowCollectionViewHeightConstraint.constant = tvDetailVC?.matchingTVShowCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }
    
    func displayTVShow(_ tvShows: [TVShow]) {
        guard var snapshot = tvDetailVC?.matchingTVShowDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .matching))
        snapshot.appendItems(tvShows, toSection: .matching)
        tvDetailVC?.matchingTVShowCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        tvDetailVC?.matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func displaySeason(tvShow: TVShow) {
        guard var snapshot = tvDetailVC?.tvShowSeasonDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .season))
        snapshot.appendItems(Array(tvShow.seasons))
        tvDetailVC?.tvShowSeasonDataSource.apply(snapshot, animatingDifferences: true)
        tvDetailVC?.tvShowSeasonTableView.layoutIfNeeded()
    }

    private func displayNetworks(tvShow: TVShow) {
        guard var snapshot = tvDetailVC?.movieNetworkImageDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .network))
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
        tvDetailVC?.originalLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ", subTitle: userSetting.languagesCode.first(where: { $0.iso6391 == tvShow.originalLanguage })?.name ?? "")
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
