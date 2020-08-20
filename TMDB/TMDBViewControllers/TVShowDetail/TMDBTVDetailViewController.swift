//
//  TMDBTVDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 7/20/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBTVDetailViewController: UIViewController {
    // MARK: - properties
    var tvId: Int?

    // MARK: - presenter
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    lazy var presenter: TMDBTVShowDetailPresenter = TMDBTVShowDetailPresenter(delegate: self)

    // MARK: - coordinate
    var coordinate: MainCoordinator?

    // MARK: - data source

    var movieNetworkImageDataSource: TMDBCollectionDataSource!

    var tvShowSeasonDataSource: TMDBTableDataSource!

    var matchingTVShowDataSource: TMDBCollectionDataSource!

    var tvShowCreditDataSource: TMDBCollectionDataSource!

    var tvShowVideoDataSource: TMDBCollectionDataSource!

    var tvShowCreatorDataSrouce: TMDBCollectionDataSource!

    var tvShowBackdropImageDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.refreshControl = UIRefreshControl()
            scrollView.refreshControl?.tintColor = Constant.Color.primaryColor
            scrollView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")

            scrollView.refreshControl?.addTarget(self, action: #selector(refreshTVShowDetail), for: .valueChanged)
        }
    }
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    weak var creditHeaderView: TMDBPreviewHeaderView?
    weak var addtionalHeaderView: TMDBPreviewHeaderView?
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var availableLanguageLabel: UILabel!
    @IBOutlet weak var tvShowCreditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var numberOfSeasonLabel: UILabel!
    @IBOutlet weak var numberOfEpisodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var keywordCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
            tvShowBackdropImageDataSource = TMDBCollectionDataSource(collectionView: backdropImageCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.imageCell, for: indexPath) as? TMDBBackdropImageCell
                cell?.configure(item: item)
                return cell
            }

            var snapshot = tvShowBackdropImageDataSource.snapshot()
            snapshot.appendSections([.backdrop])
            tvShowBackdropImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            videoCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)

            tvShowVideoDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: videoCollectionView)
            tvShowVideoDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Video", comment: "")
                return header
            }
            var snapshot = tvShowVideoDataSource.snapshot()
            snapshot.appendSections([.video])
            tvShowVideoDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout(delegate: self)
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var networkCollectionView: UICollectionView! {
        didSet {
            networkCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout(fractionWidth: 0.2, fractionHeight: 1, scrollBehavior: .continuous)
            networkCollectionView.register(TMDBNetworkImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
            movieNetworkImageDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.imageCell, collectionView: networkCollectionView)
            var snapshot = movieNetworkImageDataSource.snapshot()
            snapshot.appendSections([.network])
            movieNetworkImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var tvShowSeaonTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tvShowSeasonTableView: UITableView! {
        didSet {
            tvShowSeasonTableView.register(UINib(nibName: "TMDBCustomTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.tvShowSeasonCell)
            tvShowSeasonDataSource = TMDBTableDataSource(cellIdentifier: Constant.Identifier.tvShowSeasonCell, tableView: tvShowSeasonTableView)

            var snapshot = tvShowSeasonDataSource.snapshot()
            snapshot.appendSections([.season])
            tvShowSeasonDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var matchingTVShowCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchingTVShowCollectionView: UICollectionView! {
        didSet {
            matchingTVShowCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            matchingTVShowCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            matchingTVShowCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            matchingTVShowDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: matchingTVShowCollectionView)
            matchingTVShowDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.addtionalHeaderView = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath)) as? TMDBPreviewHeaderView
                self.addtionalHeaderView?.label.text = NSLocalizedString("More", comment: "")
                self.addtionalHeaderView?.delegate = self
                return self.addtionalHeaderView
            }
            
            var snapshot = matchingTVShowDataSource.snapshot()
            snapshot.appendSections([.matching])
            matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var tvShowCreditCollectionView: UICollectionView! {
        didSet {
            tvShowCreditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            tvShowCreditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            tvShowCreditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            tvShowCreditDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: tvShowCreditCollectionView)
            tvShowCreditDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.creditHeaderView = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath)) as? TMDBPreviewHeaderView
                self.creditHeaderView?.label.text = NSLocalizedString("Credit", comment: "")
                self.creditHeaderView?.delegate = self
                return self.creditHeaderView
            }
            
            var snapshot = tvShowCreditDataSource.snapshot()
            snapshot.appendSections([.credit])
            tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creatorCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var creatorCollectionView: UICollectionView! {
        didSet {
            creatorCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            creatorCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            creatorCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            tvShowCreatorDataSrouce = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: creatorCollectionView)
            tvShowCreatorDataSrouce.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Creator", comment: "")
                return header
            }

            var snapshot = tvShowCreatorDataSrouce.snapshot()
            snapshot.appendSections([.creator])
            tvShowCreatorDataSrouce.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        view.addSubview(loadingView)
        presenter.getTVShowDetail(tvShowId: tvId!)
    }

    override func viewDidLayoutSubviews() {
        tvShowSeaonTableViewHeightConstraint.constant = tvShowSeasonTableView.contentSize.height
    }

    // MARK: - action

    @objc func refreshTVShowDetail() {
        presenter.refreshTVShowDetail(tvShowId: tvId!)
    }

    @IBAction func reviewButtonTap() {
        let reviews = presenter.repository.getTVShowReviews(from: tvId!)
        coordinate?.navigateToReview(reivew: reviews)
    }
}
