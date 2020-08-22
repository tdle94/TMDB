//
//  TMDBTVShowEpisodeDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 8/7/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBTVSHowEpisodeDelegate {
    func 
}


class TMDBTVShowEpisodePresenter {
    
}

class TMDBTVShowEpisodeDetailDisplay {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    weak var tvShowEpisodeVC: TMDBTVShowEpisodeViewController?
    
    func displayEpisodeDetail(_ episode: Episode) {
        tvShowEpisodeVC?.title = episode.name
        displayTitleLabel(episode)
        displayPosterImage(episode)
        displayOverview(episode)
        displayCredit(episode)
        displayVideo(episode)
    }

    func displayVideo(_ episode: Episode) {
        guard var snapshot = tvShowEpisodeVC?.videoDataSource.snapshot() else {
            return
        }
        
        guard let videos = episode.videos?.videos, !videos.isEmpty else {
            snapshot.deleteSections([.video])
            tvShowEpisodeVC?.videoDataSource.apply(snapshot, animatingDifferences: true)
            tvShowEpisodeVC?.videoCollectionViewHeightConstraint.constant = 0
            return
        }
        
        snapshot.deleteAllItems()
        snapshot.appendItems(Array(videos))
        tvShowEpisodeVC?.videoDataSource.apply(snapshot, animatingDifferences: true)
        tvShowEpisodeVC?.videoCollectionViewHeightConstraint.constant = (tvShowEpisodeVC?.videoCollectionView.contentSize.height ?? 0)/2
    }
    
    func displayStillImages(_ imageResult: ImageResult) {
        guard var snapshot = tvShowEpisodeVC?.stillImageDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .backdrop))
        snapshot.appendItems(Array(imageResult.stills))
        tvShowEpisodeVC?.stillImageDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayCredit(_ episode: Episode) {
        guard
            var snapshot = tvShowEpisodeVC?.creditDataSource.snapshot(),
            let credit = episode.credits else { return }
        
        if credit.cast.isEmpty, credit.crew.isEmpty {
            snapshot.deleteSections([.credit])
            tvShowEpisodeVC?.creditDataSource.apply(snapshot, animatingDifferences: true)
            tvShowEpisodeVC?.creditCollectionViewHeightConstraint.constant = 0
            return
        }

        if !credit.cast.isEmpty {
            tvShowEpisodeVC?.creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
        }
        
        if !credit.crew.isEmpty {
            tvShowEpisodeVC?.creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Crew", comment: ""), at: 1, animated: true)
        }
        
        if !episode.guestStars.isEmpty {
            tvShowEpisodeVC?.creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Guest Star", comment: ""), at: 2, animated: true)
        }
        
        if tvShowEpisodeVC?.creditHeader?.segmentControl.numberOfSegments == 3 || credit.crew.isEmpty || episode.guestStars.isEmpty {
            displayCast(Array(credit.cast), reloadSection: false)
        } else if tvShowEpisodeVC?.creditHeader?.segmentControl.numberOfSegments == 2 || credit.cast.isEmpty || episode.guestStars.isEmpty {
            displayCrew(Array(credit.crew), reloadSection: false)
        } else if tvShowEpisodeVC?.creditHeader?.segmentControl.numberOfSegments == 1 {
            displayCast(Array(episode.guestStars), reloadSection: false)
        }
        tvShowEpisodeVC?.creditHeader?.segmentControl.selectedSegmentIndex = 0
        tvShowEpisodeVC?.creditCollectionView.collectionViewLayout.invalidateLayout()
        tvShowEpisodeVC?.creditCollectionViewHeightConstraint.constant = tvShowEpisodeVC?.creditCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }

    func displayCast(_ casts: [Cast], reloadSection: Bool = true) {
        guard var snapshot = tvShowEpisodeVC?.creditDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts)
        tvShowEpisodeVC?.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        if casts.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        tvShowEpisodeVC?.creditDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrew(_ crews: [Crew], reloadSection: Bool = true) {
        guard var snapshot = tvShowEpisodeVC?.creditDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews)
        tvShowEpisodeVC?.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        if crews.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        tvShowEpisodeVC?.creditDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayTitleLabel(_ episode: Episode) {
        let airDate: String
        
        if episode.airDate == nil || episode.airDate == "" {
            airDate = episode.name
        } else {
            airDate = "\(episode.name) \u{2022} \(episode.airDate!)"
        }

        tvShowEpisodeVC?.titleLabel.attributedText = NSAttributedString(string: airDate,
        attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }
    
    func displayPosterImage(_ episode: Episode) {
        guard
            let path = episode.stillPath,
            let url = userSetting.getImageURL(from: path) else { return }
        tvShowEpisodeVC?.posterImageView.sd_setImage(with: url)
    }

    func displayOverview(_ episode: Episode) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        tvShowEpisodeVC?.overviewDetail.attributedText = NSAttributedString(string: episode.overview,
                                                                              attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                       size: 14)!,
                                                                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                           NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
