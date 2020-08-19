//
//  TMDBMovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 6/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBMovieDetailViewController: UIViewController {
    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - properties

    var movieId: Int?

    // MARK: - data source
    var videoMovieDataSource: TMDBCollectionDataSource!

    var creditMovieDataSource: TMDBCollectionDataSource!

    var productionCompanyDataSource: TMDBCollectionDataSource!

    var matchingMoviesDataSource: TMDBCollectionDataSource!

    var movieImageDataSource: TMDBCollectionDataSource!

    // MARK: - presenter
    lazy var presenter: TMDBMovieDetailPresenter = TMDBMovieDetailPresenter(delegate: self)

    // MARK: - repository

    let userSetting: TMDBUserSetting = TMDBUserSetting()

    var repository: TMDBRepository = TMDBRepository.share

    // MARK: - ui views
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.refreshControl = UIRefreshControl()
            scrollView.refreshControl?.tintColor = Constant.Color.primaryColor
            scrollView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
            scrollView.refreshControl?.addTarget(self, action: #selector(refreshMovieDetail), for: .valueChanged)
        }
    }
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var availableLanguageLabel: UILabel!
    @IBOutlet weak var additionalInformationTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var additionalInformationTableView: UITableView!
    weak var creditHeader: TMDBPreviewHeaderView?
    weak var moreMovieHeader: TMDBPreviewHeaderView?
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchingMovieCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var taglineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewDetailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)

            movieImageDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.imageCell, collectionView: backdropImageCollectionView)

            var snapshot = movieImageDataSource.snapshot()
            snapshot.appendSections([.image])
            movieImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var generes: UILabel!
    @IBOutlet weak var keywordCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout(delegate: self)
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            videoCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            
            videoMovieDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: videoCollectionView)

            videoMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Video", comment: "")
                return header
            }
            
            var snapshot = videoMovieDataSource.snapshot()
            snapshot.appendSections([.video])
            videoMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            
            creditMovieDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: creditCollectionView)
            
            creditMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.creditHeader = (collectionView.supplementaryView(forElementKind: kind, at: indexPath)  ??
                                 collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                  withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                                  for: indexPath)) as? TMDBPreviewHeaderView
                self.creditHeader?.label.text = NSLocalizedString("Credit", comment: "")
                self.creditHeader?.delegate = self
                return self.creditHeader
            }
            
            var snapshot = creditMovieDataSource.snapshot()
            snapshot.appendSections([.credit])
            creditMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var matchingMoviesCollectionView: UICollectionView! {
        didSet {
            matchingMoviesCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            matchingMoviesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            matchingMoviesCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            matchingMoviesDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: matchingMoviesCollectionView)

            matchingMoviesDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.moreMovieHeader = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ??
                                        collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                        withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                                        for: indexPath)) as? TMDBPreviewHeaderView
                self.moreMovieHeader?.delegate = self
                self.moreMovieHeader?.label.text = NSLocalizedString("More", comment: "")
                return self.moreMovieHeader
            }

            var snapshot = matchingMoviesDataSource.snapshot()
            snapshot.appendSections([.more])
            matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(fractionWidth: 0.2, fractionHeight: 0.4)
            productionCompaniesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            productionCompaniesCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)

            productionCompanyDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: productionCompaniesCollectionView)
            productionCompanyDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                             for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Produce by", comment: "")
                return header
            }

            var snapshot = productionCompanyDataSource.snapshot()
            snapshot.appendSections([.productionCompanies])
            productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var moviePosterImageView: UIImageView! {
        didSet {
            moviePosterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            moviePosterImageView.roundImage()
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        contentView.bringSubviewToFront(moviePosterImageView)
        view.addSubview(loadingView)
        scrollView.contentSize = UIScreen.main.bounds.size
        // movie detail
        presenter.getMovieDetail(movieId: movieId!)
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }

    // MARK: - service call

    @objc func refreshMovieDetail() {
        presenter.refreshMovieDetail(movieId: movieId!)
    }
}
