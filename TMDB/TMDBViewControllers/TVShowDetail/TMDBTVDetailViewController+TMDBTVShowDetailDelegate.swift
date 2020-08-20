//
//  TMDBTVDetailViewController+TMDBTVShowDetailDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVDetailViewController: TMDBTVShowDetailDelegate {
    func displayTVShowDetail(tvShow: TVShow) {
        loadingView.removeFromSuperview()
        presenter.getBackdropImages(tvShowId: tvId!)

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

        title = tvShow.originalName
    }
    
    func displayTVShows(tvShows: [TVShow]) {
        var snapshot = matchingTVShowDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .matching))
        snapshot.appendItems(tvShows, toSection: .matching)
        matchingTVShowCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayCasts(casts: [Cast]) {
        var snapshot = tvShowCreditDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts)
        tvShowCreditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: false)
        tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayCrews(crews: [Crew]) {
        var snapshot = tvShowCreditDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews)
        tvShowCreditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: false)
        tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - display subviews
    
    func displayBackdropImage(images: [Images]) {
        var snapshot = tvShowBackdropImageDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .backdrop))
        snapshot.appendItems(images)
        tvShowBackdropImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCreator(tvShow: TVShow) {
        var snapshot = tvShowCreatorDataSrouce.snapshot()
        guard !tvShow.createdBy.isEmpty else {
            snapshot.deleteSections([.creator])
            tvShowCreatorDataSrouce.apply(snapshot, animatingDifferences: true)
            creatorCollectionViewHeightConstraint.constant = 0
            return
        }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .creator))
        snapshot.appendItems(Array(tvShow.createdBy))
        tvShowCreatorDataSrouce.apply(snapshot, animatingDifferences: true)
        creatorCollectionViewHeightConstraint.constant = creatorCollectionView.collectionViewLayout.collectionViewContentSize.height/1.1
    }

    func displayVideos(tvShow: TVShow) {
        var snapshot = tvShowVideoDataSource.snapshot()
        guard let videos = tvShow.videos?.videos, !videos.isEmpty else {
            snapshot.deleteSections([.video])
            tvShowVideoDataSource.apply(snapshot, animatingDifferences: true)
            videoCollectionViewHeightConstraint.constant = 0
            return
        }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .video))
        snapshot.appendItems(Array(videos))
        tvShowVideoDataSource.apply(snapshot, animatingDifferences: true)
        videoCollectionViewHeightConstraint.constant = videoCollectionView.collectionViewLayout.collectionViewContentSize.height/2
    }

    func displayReviewLabel(tvShow: TVShow) {
        reviewButton.setAttributedTitle(NSAttributedString(string: NSLocalizedString("Review", comment: "") + " (\(tvShow.reviews?.totalResults ?? 0))",
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
            availableLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Available Languages", comment: "") + ": ", subTitle: languages.joined(separator: ", "))
        }
    }
    
    func displayCredit(tvShow: TVShow) {
        guard
            let crew = tvShow.credits?.crew,
            let cast = tvShow.credits?.cast
            else { return }
        
        var snapshot = tvShowCreditDataSource.snapshot()

        if cast.isEmpty, crew.isEmpty {
            snapshot.deleteSections([.credit])
            tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        creditHeaderView?.segmentControl.removeAllSegments()

        if !cast.isEmpty {
            creditHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
        }
        
        if !crew.isEmpty {
            creditHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Crew", comment: ""), at: 1, animated: true)
        }
        
        if creditHeaderView?.segmentControl.numberOfSegments == 2 || crew.isEmpty {
            displayCast(Array(cast), reloadSection: false)
        } else if creditHeaderView?.segmentControl.numberOfSegments == 1 {
            displayCrew(Array(crew), reloadSection: false)
        }
        
        creditHeaderView?.segmentControl.selectedSegmentIndex = 0
        tvShowCreditCollectionView.collectionViewLayout.invalidateLayout()
        tvShowCreditCollectionViewHeightConstraint.constant = tvShowCreditCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func displayCast(_ casts: [Cast], reloadSection: Bool = true) {
        var snapshot = tvShowCreditDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts)
        tvShowCreditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: false)
        if casts.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrew(_ crews: [Crew], reloadSection: Bool = true) {
        var snapshot = tvShowCreditDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews)
        tvShowCreditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: false)
        if crews.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayMoreTVShows(tvShow: TVShow) {
        guard
            let similar = tvShow.similar,
            let recommend = tvShow.recommendations else { return }

        var snapshot = matchingTVShowDataSource.snapshot()

        if similar.onTV.isEmpty, recommend.onTV.isEmpty {
            snapshot.deleteSections([.matching])
            matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
            return
        }
        addtionalHeaderView?.segmentControl.removeAllSegments()
        if !similar.onTV.isEmpty {
            addtionalHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Similar", comment: ""), at: 0, animated: true)
        }

        if !recommend.onTV.isEmpty {
            addtionalHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Recommend", comment: ""), at: 1, animated: true)
        }
        
        if addtionalHeaderView?.segmentControl.numberOfSegments == 2 || recommend.onTV.isEmpty {
            displayTVShow(Array(similar.onTV))
        } else if addtionalHeaderView?.segmentControl.numberOfSegments == 1 {
            displayTVShow(Array(recommend.onTV))
        }
        addtionalHeaderView?.segmentControl.selectedSegmentIndex = 0
        matchingTVShowCollectionView.collectionViewLayout.invalidateLayout()
        matchingTVShowCollectionViewHeightConstraint.constant = matchingTVShowCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func displayTVShow(_ tvShows: [TVShow]) {
        var snapshot = matchingTVShowDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .matching))
        snapshot.appendItems(tvShows, toSection: .matching)
        matchingTVShowCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func displaySeason(tvShow: TVShow) {
        var snapshot = tvShowSeasonDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .season))
        snapshot.appendItems(Array(tvShow.seasons))
        tvShowSeasonDataSource.apply(snapshot, animatingDifferences: true)
        tvShowSeasonTableView.layoutIfNeeded()
    }

    private func displayNetworks(tvShow: TVShow) {
        var snapshot = movieNetworkImageDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .network))
        snapshot.appendItems(Array(tvShow.networks))
        movieNetworkImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    private func displayKeywords() {
        keywordCollectionView.reloadData()
        keywordCollectionView.layoutIfNeeded()
        keywordCollectionViewHeightConstraint.constant = keywordCollectionView.contentSize.height
    }

    private func displayOverview(tvShow: TVShow) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        if tvShow.overview == "" {
            overviewLabel.isHidden = true
        }
        overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                                             attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                              size: UIFont.labelFontSize)!])
        overviewDetailLabel.attributedText = NSAttributedString(string: tvShow.overview,
                                                                              attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                       size: 14)!,
                                                                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                           NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    private func displayTitleLabel(tvShow: TVShow) {
        titleLabel.attributedText = NSAttributedString(string: tvShow.originalName,
                                                                   attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    private func displayRuntimeLabel(tvShow: TVShow) {
        var runtimes = Array(tvShow.episodeRunTime).map { "\($0)" }.joined(separator: ", ")
        if runtimes != "" {
            runtimes = "\(runtimes) mins \u{2022} \(tvShow.firstAirDate)"
        }
        runtimeLabel.attributedText = NSAttributedString(string: runtimes,
                                                                     attributes: [
                                                                        NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                    ])
    }

    private func displayStatusLabel(tvShow: TVShow) {
        statusLabel.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ", subTitle: tvShow.status)
    }

    private func displayGenreLabel(tvShow: TVShow) {
        let genres = Array(tvShow.genres).map { "\($0.name)" }.joined(separator: ", ")
        genresLabel.attributedText = NSAttributedString(string: genres,
                                                                    attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                     size: UIFont.smallSystemFontSize)!])
    }

    private func displayTypeLabel(tvShow: TVShow) {
        typeLabel.attributedText = constructAttrsString(title: NSLocalizedString("Type", comment: "") + ": ", subTitle: tvShow.type)
    }

    private func displayOriginalLanguageLabel(tvShow: TVShow) {
        originalLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ", subTitle: userSetting.languagesCode.first(where: { $0.iso6391 == tvShow.originalLanguage })?.name ?? "")
    }

    private func displayNumberOfSeason(tvShow: TVShow) {
        numberOfSeasonLabel.attributedText = constructAttrsString(title: NSLocalizedString("Number Of Season", comment: "") + ": ", subTitle: String(tvShow.numberOfSeasons))
    }

    private func displayNumberOfEpisode(tvShow: TVShow) {
        numberOfEpisodeLabel.attributedText = constructAttrsString(title: NSLocalizedString("Number Of Episode", comment: "") + ": ", subTitle: String(tvShow.numberOfEpisodes))
    }

    private func displayPosterImageView(tvShow: TVShow) {
        guard
            let posterPath = tvShow.posterPath,
            let url = userSetting.getImageURL(from: posterPath)
            else { return }
        posterImageView.sd_setImage(with: url)
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
