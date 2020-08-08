//
//  TVShowEpisodeViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 8/6/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBTVShowEpisodeViewController: UIViewController {
    // MARK: - properties
    var tvId: Int?
    var seasonNumber: Int?
    var episodeNumber: Int?

    // MARK: - repository
    var repository: TMDBRepository = TMDBRepository.share

    // MARK: - display

    var episodeDetailDisplay: TMDBTVShowEpisodeDetailDisplay = TMDBTVShowEpisodeDetailDisplay()

    // MARK: - data source
    var creditDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    weak var creditHeader: TMDBPreviewHeaderView?
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    @IBOutlet weak var creditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            creditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            creditDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.preview, collectionView: creditCollectionView)
            creditDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.creditHeader = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath)) as? TMDBPreviewHeaderView
                self.creditHeader?.delegate = self
                self.creditHeader?.label.text = NSLocalizedString("Credit", comment: "")
                return self.creditHeader
            }
            var snapshot = creditDataSource.snapshot()
            snapshot.appendSections([.credit])
            creditDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    // MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        episodeDetailDisplay.tvShowEpisodeVC = self
        getTVShowEpisode()
    }
    
    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
    
    // MARK: - service
    func getTVShowEpisode() {
        guard
            let tvId = tvId,
            let seasonNumber = seasonNumber,
            let episodeNumber = episodeNumber else { return }

        view.addSubview(loadingView)
        repository.getTVShowEpisode(from: tvId, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { result in
            self.loadingView.removeFromSuperview()
            switch result {
            case .failure(let error):
                self.loadingView.showError(true)
                debugPrint(error.localizedDescription)
            case .success(let episode):
                self.episodeDetailDisplay.displayEpisodeDetail(episode)
            }
        }
    }
    
    func getEpisodeCast() {
        guard let tvId = tvId, let seasonNumber = seasonNumber, let episodeNumber = episodeNumber else { return }
        let casts = repository.getTVShowEpisodeCast(from: tvId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        episodeDetailDisplay.displayCast(casts)
    }
    
    func getEpisodeCrew() {
        guard let tvId = tvId, let seasonNumber = seasonNumber, let episodeNumber = episodeNumber else { return }
        let crews = repository.getTVShowEpisodeCrew(from: tvId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        episodeDetailDisplay.displayCrew(crews)
    }
    
    func getEpisodeGuestStar() {
        guard let tvId = tvId, let seasonNumber = seasonNumber, let episodeNumber = episodeNumber else { return }
        let guestStar = repository.getTVShowEpisodeGuestStar(from: tvId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        episodeDetailDisplay.displayCast(guestStar)
    }
}

extension TMDBTVShowEpisodeViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(at index: Int, text selected: String) {
        if selected == NSLocalizedString("Cast", comment: "") {
            getEpisodeCast()
        } else if selected == NSLocalizedString("Crew", comment: "") {
            getEpisodeCrew()
        } else if selected == NSLocalizedString("Guest Star", comment: "") {
            getEpisodeGuestStar()
        }
    }
}
