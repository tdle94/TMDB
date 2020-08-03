//
//  TMDBTVShowSeasonViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 01.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMDBTVShowSeasonViewController: UIViewController {
    var tvId: Int?

    var seasonNumber: Int?

    var coordinate: MainCoordinator?

    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    var repository: TMDBRepository = TMDBRepository.share

    var tvShowSeasonDisplay: TMDBTVShowSeasonDisplay = TMDBTVShowSeasonDisplay()

    enum SeasonSection: String, CaseIterable {
        case Episode = "Episode"
    }

    enum CreditSection: String, CaseIterable {
        case Credit = "Credit"
    }

    enum VideoSection: String, CaseIterable {
        case Video = "Video"
    }

    var episodeDataSource: UITableViewDiffableDataSource<SeasonSection, Episode>!

    var creditDataSource: UICollectionViewDiffableDataSource<CreditSection, Cast>!

    var videoDataSource: UICollectionViewDiffableDataSource<VideoSection, Video>!
    
    // MARK: - ui
    @IBOutlet weak var scrollView: UIScrollView!
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    @IBOutlet weak var episodeTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            videoCollectionView.register(TMDBVideoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.videoMovieHeader)
            
            videoDataSource = UICollectionViewDiffableDataSource(collectionView: videoCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }
            
            videoDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.videoMovieHeader, for: indexPath) as? TMDBVideoHeaderView
                return header
            }
            
            var snapshot = videoDataSource.snapshot()
            snapshot.appendSections([.Video])
            videoDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            creditCollectionView.register(TMDBCreditHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.creditMovieHeader)
            
            creditDataSource = UICollectionViewDiffableDataSource(collectionView: creditCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }

            creditDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.creditMovieHeader,
                                                                             for: indexPath) as? TMDBCreditHeaderView
                header?.segmentControl.removeSegment(at: 1, animated: false)
                return header
            }
            
            var snapshot = creditDataSource.snapshot()
            snapshot.appendSections([.Credit])
            creditDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
            episodeDataSource = UITableViewDiffableDataSource(tableView: episodeTableView) { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.tvShowEpisodeCell, for: indexPath)
                cell.textLabel?.text = item.name
                cell.detailTextLabel?.text = item.overview
                if let path = item.stillPath, let url = self.userSetting.getImageURL(from: path) {
                    cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage")) { _, _, _, _ in
                        cell.layoutSubviews()
                    }
                }
                return cell
            }

            var snapshot = episodeDataSource.snapshot()
            snapshot.appendSections([.Episode])
            episodeDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        tvShowSeasonDisplay.tvShowSeasonVC = self
        view.addSubview(loadingView)
        getSeason()
    }
    
    override func viewDidLayoutSubviews() {
        episodeTableViewHeightConstraint.constant = episodeTableView.contentSize.height
    }
    
    // MARK: - service
    func getSeason() {
        guard let id = tvId, let number = seasonNumber else { return }
        repository.getTVShowSeasonDetail(from: id, seasonNumber: number) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.loadingView.showError(true)
            case .success(let season):
                self.loadingView.removeFromSuperview()
                self.tvShowSeasonDisplay.displaySeason(season)
            }
        }
    }
}
