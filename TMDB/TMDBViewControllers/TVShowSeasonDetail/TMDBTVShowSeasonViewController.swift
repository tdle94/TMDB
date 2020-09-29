//
//  TMDBTVShowSeasonViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 01.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBTVShowSeasonViewController: UIViewController {
    // MARK: - properties
    var tvId: Int?

    var seasonNumber: Int?
    // MARK: - coordinate
    var coordinate: Coordinator?

    // MARK: - user setting
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    // MARK: - presenter
    lazy var presenter: TMDBTVShowSeasonPresenter = TMDBTVShowSeasonPresenter(delegate: self)

    // MARK: - data source
    var episodeDataSource: TMDBTableDataSource!

    var creditDataSource: TMDBCollectionDataSource!

    var videoDataSource: TMDBCollectionDataSource!
    
    var posterImageDataSource: TMDBCollectionDataSource!
    
    // MARK: - ui
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var posterImageCollectionView: UICollectionView! {
        didSet {
            posterImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            posterImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
            posterImageDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.imageCell, collectionView: posterImageCollectionView)

            var snapshot = posterImageDataSource.snapshot()
            snapshot.appendSections([.backdrop])
            posterImageDataSource.apply(snapshot, animatingDifferences: true)
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
            videoCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            videoCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            
            videoDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: videoCollectionView)
            
            videoDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Video", comment: "")
                return header
            }
            
            var snapshot = videoDataSource.snapshot()
            snapshot.appendSections([.video])
            videoDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            
            creditDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: creditCollectionView)

            creditDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                             for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Credit", comment: "")
                if header?.segmentControl.numberOfSegments == 0 {
                    header?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
                }
                header?.segmentControl.selectedSegmentIndex = 0
                return header
            }
            
            var snapshot = creditDataSource.snapshot()
            snapshot.appendSections([.credit])
            creditDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
            episodeTableView.register(UINib(nibName: "TMDBCustomTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.tvShowEpisodeCell)
            episodeDataSource = TMDBTableDataSource(cellIdentifier: Constant.Identifier.tvShowEpisodeCell, tableView: episodeTableView)

            var snapshot = episodeDataSource.snapshot()
            snapshot.appendSections([.episode])
            episodeDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        contentView.bringSubviewToFront(posterImageView)
        view.addSubview(loadingView)
        presenter.getSeasonDetail(tvId: tvId!, seasonNumber: seasonNumber!)
    }
    
    override func viewDidLayoutSubviews() {
        episodeTableView.layoutIfNeeded()
        episodeTableViewHeightConstraint.constant = episodeTableView.contentSize.height
    }
    
    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
}
