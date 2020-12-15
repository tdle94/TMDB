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

    // MARK: - coordinator
    var coordinate: Coordinator?

    // MARK: - presentor
    lazy var presenter: TMDBTVShowEpisodePresenter = TMDBTVShowEpisodePresenter(delegate: self)

    // MARK: - display

    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    // MARK: - data source
    var creditDataSource: TMDBCollectionDataSource!

    var stillImageDataSource: TMDBCollectionDataSource!

    var videoDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    weak var creditHeader: TMDBPreviewHeaderView?
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            //videoCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
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
    @IBOutlet weak var stillImageCollectionView: UICollectionView! {
        didSet {
            stillImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            stillImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
            stillImageDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.imageCell, collectionView: stillImageCollectionView)
            
            var snapshot = stillImageDataSource.snapshot()
            snapshot.appendSections([.backdrop])
            stillImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    @IBOutlet weak var creditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            creditDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: creditCollectionView)
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        view.addSubview(loadingView)
        contentView.bringSubviewToFront(posterImageView)
        presenter.getEpisodeDetail(tvShowId: tvId!, seasonNumber: seasonNumber!, episodeNumber: episodeNumber!)
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
}
