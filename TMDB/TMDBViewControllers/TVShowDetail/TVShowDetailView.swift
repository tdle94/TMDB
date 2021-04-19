//
//  TVShowDetailView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RealmSwift

class TVShowDetailView: UIViewController {
    var tvShowId: Int?
    
    weak var delegate: AppCoordinator?
    
    let viewModel: TVShowDetailViewModelProtocol
    
    // MARK: - datasource
    
    let creditDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item)
        return cell as! UICollectionViewCell
    })
    
    let tvshowDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item)
        return cell as! UICollectionViewCell
    })
    // MARK: - constraint
    
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewHeight: NSLayoutConstraint!
    
    // MARK: - disposables
    var castHeaderDisposable: Disposable?
    var moreMovieHeaderDisposable: Disposable?
    
    // MARK: - views
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var episodeRuntimeLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstAirdateLabel: UILabel!
    @IBOutlet weak var numberOfEpisodeLabel: UILabel!
    @IBOutlet weak var numberOfSeasonLabel: UILabel!
    @IBOutlet weak var inProductionLabel: UILabel!
    @IBOutlet weak var lastAirDateLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ratingLabel: TMDBCircleUserRating!
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBCreditHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            creditDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                       for: indexPath)
            }
        }
    }
    @IBOutlet weak var tvshowCollectionView: UICollectionView! {
        didSet {
            tvshowCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            tvshowCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            tvshowCollectionView.register(TMDBMovieLikeThisHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            tvshowDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                       for: indexPath)
            }
        }
    }
    @IBOutlet weak var reviewTableView: UITableView! {
        didSet {
            reviewTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.cell)
            reviewTableView
                .rx
                .itemSelected
                .subscribe { event in
                    guard let indexPath = event.element, let id = self.tvShowId else {
                        return
                    }

                    if indexPath.row == 0 {
                        self.delegate?.navigateToReview(reviews: self.viewModel.getTVShowReview(tvShowId: self.tvShowId!))
                    } else {
                        self.delegate?.navigateToListSeason(season: self.viewModel.getTVShowSeasons(tvShowId: self.tvShowId!),
                                                            tvShowId: id)
                    }
                }
                .disposed(by: rx.disposeBag)

        }
    }
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout()
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.collectionViewLayout = TMDBKeywordLayout()
            genreCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            posterImage.layer.borderWidth = 1
            posterImage.roundImage()
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = backdropImageCollectionView

        }
    }
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    
    // MARK: - init
    init(viewModel: TVShowDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TVShowDetailView.self), bundle: nil)
    }
    
    // MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLoveIcon()
        navigationItem.setBackArrowIcon()
        setupBinding()
        getTVShowDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        genreCollectionViewHeight.constant = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        keywordCollectionViewHeight.constant = keywordCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        genreCollectionView.layoutIfNeeded()
        keywordCollectionView.layoutIfNeeded()
        creditCollectionView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - get tvshow detail
    func getTVShowDetail() {
        numberOfEpisodeLabel.showAnimatedGradientSkeleton()
        numberOfSeasonLabel.showAnimatedGradientSkeleton()
        inProductionLabel.showAnimatedGradientSkeleton()
        firstAirdateLabel.showAnimatedGradientSkeleton()
        lastAirDateLabel.showAnimatedGradientSkeleton()
        originalLanguageLabel.showAnimatedGradientSkeleton()
        statusLabel.showAnimatedGradientSkeleton()
        languagesLabel.showAnimatedGradientSkeleton()
        countriesLabel.showAnimatedGradientSkeleton()
        overviewLabel.showAnimatedGradientSkeleton()
        homepageLabel.showAnimatedGradientSkeleton()
        episodeRuntimeLabel.showAnimatedGradientSkeleton()
        titleLabel.showAnimatedGradientSkeleton()
        stackView.showAnimatedGradientSkeleton()
        posterImage.showAnimatedGradientSkeleton()
        scrollView.parallaxHeader.contentView.showAnimatedGradientSkeleton()
        
        if let id = tvShowId {
            viewModel.getImages(tvShowId: id)
            viewModel.getTVShowDetail(tvShowId: id)
        }
    }
}

extension TVShowDetailView {
    
    func setupBinding() {
        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)
        
        
        // scrollview binding
        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)
        
        // backdrop images binding
        viewModel
            .backdropImages
            .bind(to: backdropImageCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { _, image, cell in
                (cell as? TMDBBackdropImageCell)?.configure(item: image)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .backdropImages
            .subscribe { event in
                self.scrollView.parallaxHeader.dots = event.element?.count ?? 0
            }
            .disposed(by: rx.disposeBag)
        
        backdropImageCollectionView
            .rx
            .didEndDisplayingCell
            .subscribe { _, indexPath in
                guard let index = self.backdropImageCollectionView.indexPathsForVisibleItems.first?.row else {
                    return
                }
                self.scrollView.parallaxHeader.selectDot(at: index)
            }
            .disposed(by: rx.disposeBag)
        
        // keyword binding
        viewModel
            .keywords
            .bind(to: keywordCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { _, keyword, cell in
                (cell as? TMDBKeywordCell)?.configure(item: keyword)
            }
            .disposed(by: rx.disposeBag)

        viewModel
            .keywords
            .asObserver()
            .subscribe { event in
                guard let keywords = event.element else {
                    return
                }
                (self.keywordCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = keywords.map { $0.name }
            }
            .disposed(by: rx.disposeBag)
        
        // tvshow detail binding
        viewModel
            .tvShowDetail
            .observeOn(MainScheduler.asyncInstance)
            .subscribe { event in
                guard let tvShowDetail = event.element else {
                    return
                }

                if let path = tvShowDetail.posterPath,
                   let url = self.viewModel.userSetting.getImageURL(from: path) {
                    self.posterImage.sd_setImage(with: url)
                }
                
                self.ratingLabel.rating = tvShowDetail.voteAverage
                self.title = tvShowDetail.name
                
                self.numberOfEpisodeLabel.hideSkeleton()
                self.numberOfSeasonLabel.hideSkeleton()
                self.inProductionLabel.hideSkeleton()
                self.firstAirdateLabel.hideSkeleton()
                self.lastAirDateLabel.hideSkeleton()
                self.originalLanguageLabel.hideSkeleton()
                self.statusLabel.hideSkeleton()
                self.languagesLabel.hideSkeleton()
                self.countriesLabel.hideSkeleton()
                self.overviewLabel.hideSkeleton()
                self.homepageLabel.hideSkeleton()
                self.episodeRuntimeLabel.hideSkeleton()
                self.titleLabel.hideSkeleton()
                self.stackView.hideSkeleton()
                self.posterImage.hideSkeleton()
                self.scrollView.parallaxHeader.contentView.hideSkeleton()
            }
            .disposed(by: rx.disposeBag)
        
        // review and season table binding
        viewModel
            .reviewAndEpisode
            .bind(to: self.reviewTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, text, cell in
                cell.textLabel?.setHeader(title: text)
            }
            .disposed(by: self.rx.disposeBag)
        
        // genre collection view binding
        viewModel
            .genres
            .bind(to: self.genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { _, genre, cell in
                (cell as? TMDBKeywordCell)?.configure(item: genre)
            }
            .disposed(by: self.rx.disposeBag)
        
        viewModel
            .genres
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { genres in
                (self.genreCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = genres.map { $0.name }
            })
            .disposed(by: rx.disposeBag)
        
        // credit binding
        viewModel
            .credits
            .bind(to: creditCollectionView.rx.items(dataSource: creditDataSource))
            .disposed(by: rx.disposeBag)
        

        creditCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.delegate?.navigateWith(obj: self.creditDataSource.sectionModels.first?.items[indexPath.row])
            })
            .disposed(by: rx.disposeBag)
        
        creditCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementary, _, _ in
                let header = supplementary as? TMDBCreditHeaderView
                
                header?
                    .segmentControl
                    .rx
                    .value
                    .changed
                    .asDriver()
                    .drive(onNext: { index in
                        self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handleCreditSelection(at: index, tvshowId: self.tvShowId!)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        
        // tv show binding
        viewModel
            .tvshows
            .bind(to: tvshowCollectionView.rx.items(dataSource: tvshowDataSource))
            .disposed(by: rx.disposeBag)
        
        tvshowCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.delegate?.navigateWith(obj: self.tvshowDataSource.sectionModels.first?.items[indexPath.row])
            })
            .disposed(by: rx.disposeBag)
        
        tvshowCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementary, _, _ in
                let header = supplementary as? TMDBMovieLikeThisHeaderView
                
                header?
                    .segmentControl
                    .rx
                    .value
                    .changed
                    .asDriver()
                    .drive(onNext: { index in
                        self.tvshowCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handleTVShowLikeThisSelection(at: index, tvshowId: self.tvShowId!)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        
        // label binding
        viewModel
            .numberOfSeason
            .bind(to: numberOfSeasonLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .numberOfEpisode
            .bind(to: numberOfEpisodeLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .inProduction
            .bind(to: inProductionLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .firstAirDate
            .bind(to: firstAirdateLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .lastAirDate
            .bind(to: lastAirDateLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .originalLanguage
            .bind(to: originalLanguageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .status
            .bind(to: statusLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .countries
            .bind(to: countriesLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .languages
            .bind(to: languagesLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        
        viewModel
            .title
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .homepage
            .bind(to: homepageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .episodeRuntime
            .bind(to: episodeRuntimeLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .overview
            .bind(to: overviewLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
    }
}
