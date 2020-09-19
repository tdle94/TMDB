//
//  TMDBTVShowEpisodeViewController+TMDBTVShowEpisodeDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVShowEpisodeViewController: TMDBTVShowEpisodeDelegate {
    func displayEpisode(episode: Episode) {
        loadingView.removeFromSuperview()
        presenter.getEpisodeImage(tvShowId: tvId!, seasonNumber: seasonNumber!, episodeNumber: episodeNumber!)
        title = episode.name
        displayTitleLabel(episode: episode)
        displayPosterImage(episode: episode)
        displayOverview(episode: episode)
        displayCredit(episode: episode)
        displayVideo(episode: episode)
    }

    func displayCasts(casts: [Cast]) {
        var snapshot = creditDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts)
        creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        creditDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrews(crews: [Crew]) {
        var snapshot = creditDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews)
        creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        creditDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayImages(images: [Images]) {
        var snapshot = stillImageDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .backdrop))
        snapshot.appendItems(images)
        stillImageDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - display subviews
    func displayVideo(episode: Episode) {
        var snapshot = videoDataSource.snapshot()

        guard let videos = episode.videos?.videos, !videos.isEmpty else {
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
    
    func displayCredit(episode: Episode) {
        guard let credit = episode.credits else { return }
        var snapshot = creditDataSource.snapshot()
        if credit.cast.isEmpty, credit.crew.isEmpty {
            snapshot.deleteSections([.credit])
            creditDataSource.apply(snapshot, animatingDifferences: true)
            creditCollectionViewHeightConstraint.constant = 0
            return
        }

        if !credit.cast.isEmpty {
            creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
        }
        
        if !credit.crew.isEmpty {
            creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Crew", comment: ""), at: 1, animated: true)
        }
        
        if !episode.guestStars.isEmpty {
            creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Guest Star", comment: ""), at: 2, animated: true)
        }
        
        if creditHeader?.segmentControl.numberOfSegments == 3 || credit.crew.isEmpty || episode.guestStars.isEmpty {
            displayCasts(casts: Array(credit.cast))
        } else if creditHeader?.segmentControl.numberOfSegments == 2 || credit.cast.isEmpty || episode.guestStars.isEmpty {
            displayCrews(crews: Array(credit.crew))
        } else if creditHeader?.segmentControl.numberOfSegments == 1 {
            displayCasts(casts: Array(episode.guestStars))
        }
        creditHeader?.segmentControl.selectedSegmentIndex = 0
        creditCollectionView.collectionViewLayout.invalidateLayout()
        creditCollectionViewHeightConstraint.constant = creditCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func displayTitleLabel(episode: Episode) {
        let airDate: String
        
        if episode.airDate == nil || episode.airDate == "" {
            airDate = episode.name
        } else {
            airDate = "\(episode.name) \u{2022} \(episode.airDate!)"
        }

        titleLabel.attributedText = NSAttributedString(string: airDate,
        attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }
    
    func displayPosterImage(episode: Episode) {
        guard
            let path = episode.stillPath,
            let url = userSetting.getImageURL(from: path) else { return }
        posterImageView.sd_setImage(with: url)
    }

    func displayOverview(episode: Episode) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        overviewDetail.attributedText = NSAttributedString(string: episode.overview,
                                                           attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                            size: 14)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                        NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
