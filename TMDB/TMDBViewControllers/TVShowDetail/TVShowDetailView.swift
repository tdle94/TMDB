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

class TVShowDetailView: UIViewController {
    var tvShowId: Int?
    
    weak var delegate: TVShowDetailViewDelegate?
    
    let viewModel: TVShowDetailViewModelProtocol
    
    // MARK: - datasource
    let dataSource: RxCollectionViewSectionedReloadDataSource<TVShowDetailModel> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item.identity)
        return cell as! UICollectionViewCell
    })
    
    // MARK: - constraint
    
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeight: NSLayoutConstraint!

    // MARK: - views
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
            if UIDevice.current.userInterfaceIdiom == .pad {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.2, heightDimension: 0.43)
            } else {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.45)
            }

            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBCreditHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            creditCollectionView.register(TMDBMovieLikeThisHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.moviePreviewHeader)
            dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                switch dataSource.sectionModels[indexPath.section] {
                case .Credits(items: _):
                    let creditHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                       withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                                       for: indexPath) as! TMDBCreditHeaderView
                    
                    if creditHeader.segmentControl.selectedSegmentIndex == -1 {
                        creditHeader.segmentControl.selectedSegmentIndex = 0
                        creditHeader
                            .segmentControl
                            .rx
                            .value
                            .changed
                            .subscribe { event in
                                let index = Int(event.element!.description)
                                self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: indexPath.section), at: .centeredHorizontally, animated: true)

                                if index == 0, creditHeader.segmentControl.titleForSegment(at: 0) == NSLocalizedString("Cast", comment: "") {
                                    self.viewModel.getCasts(tvShowId: self.tvShowId!)
                                } else {
                                    self.viewModel.getCrews(tvShowId: self.tvShowId!)
                                }
                            }
                            .disposed(by: self.rx.disposeBag)
                    }
                    
                    return creditHeader
                case .TVShowsLikeThis(items: _):
                    let movieHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                      withReuseIdentifier: Constant.Identifier.moviePreviewHeader,
                                                                                      for: indexPath) as! TMDBMovieLikeThisHeaderView
                    if movieHeader.segmentControl.selectedSegmentIndex == -1 {
                        movieHeader.segmentControl.selectedSegmentIndex = 0
                        movieHeader
                            .segmentControl
                            .rx
                            .value
                            .changed
                            .subscribe { event in
                                let index = Int(event.element!.description)
                                self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: indexPath.section), at: .centeredHorizontally, animated: true)

                                if index == 0, movieHeader.segmentControl.titleForSegment(at: 0) == NSLocalizedString("Similar", comment: "") {
                                    self.viewModel.getSimilars(tvShowId: self.tvShowId!)
                                } else {
                                    self.viewModel.getRecommends(tvShowId: self.tvShowId!)
                                }
                            }
                            .disposed(by: self.rx.disposeBag)
                    }
                    
                    return movieHeader
                }
            }
        }
    }
    @IBOutlet weak var reviewTableView: UITableView! {
        didSet {
            reviewTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.reviewCell)
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
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.collectionViewLayout = TMDBKeywordLayout()
            genreCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
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
            scrollView.parallaxHeader.height = ceil(UIScreen.main.bounds.height / 2.7)
            scrollView.parallaxHeader.minimumHeight = 0

        }
    }
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
        }
    }
    
    init(viewModel: TVShowDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TVShowDetailView.self), bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.setToPreviousAlpha(safeAreaInsetTop: view.safeAreaInsets.top,
                                      navigationController: navigationController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.resetNavBar()
        scrollView.setForegroundColor(alpha: 1, navigationController: navigationController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLoveIcon()
        navigationItem.setBackArrowIcon()
        setupBinding()
        setupViewLayout()
        if let id = tvShowId {
            viewModel.getImages(tvShowId: id)
            viewModel.getTVShowDetail(tvShowId: id)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        genreCollectionViewHeight.constant = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        keywordCollectionViewHeight.constant = keywordCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        genreCollectionView.layoutIfNeeded()
        keywordCollectionView.layoutIfNeeded()
        creditCollectionView.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowDetailView {
    func setupViewLayout() {
        if UIDevice.current.userInterfaceIdiom != .pad {
            posterImageViewTop.constant += scrollView.contentOffset.y/4
        }
    }
    
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
            .bind(to: backdropImageCollectionView.rx.items(cellIdentifier: Constant.Identifier.imageCell)) { _, image, cell in
                (cell as? TMDBBackdropImageCell)?.configure(item: image)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .backdropImages
            .subscribe { event in
                self.scrollView.parallaxHeader.carouselView = CarouselView(numberOfDot: event.element?.count ?? 0)
            }
            .disposed(by: rx.disposeBag)
        
        backdropImageCollectionView
            .rx
            .didEndDisplayingCell
            .subscribe { _, indexPath in
                guard let index = self.backdropImageCollectionView.indexPathsForVisibleItems.first?.row else {
                    return
                }
                self.scrollView.parallaxHeader.carouselView?.selectDot(at: index)
            }
            .disposed(by: rx.disposeBag)
        
        // keyword binding
        viewModel
            .keywords
            .bind(to: keywordCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { _, keyword, cell in
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
            }
            .disposed(by: rx.disposeBag)
        
        // review and season table binding
        viewModel
            .reviewAndEpisode
            .bind(to: self.reviewTableView.rx.items(cellIdentifier: Constant.Identifier.reviewCell)) { index, text, cell in
                cell.textLabel?.setHeader(title: text)
            }
            .disposed(by: self.rx.disposeBag)
        
        // genre collection view binding
        viewModel
            .genres
            .bind(to: self.genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { _, genre, cell in
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
            .catchErrorJustReturn(dataSource.sectionModels)
            .bind(to: creditCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)

        creditCollectionView
            .rx
            .willDisplaySupplementaryView
            .observeOn(MainScheduler.asyncInstance)
            .subscribe { event in

                if !self.viewModel.isThereCast, !self.viewModel.isThereCrew {
                    self.viewModel.resetCreditHeaderState()
                    self.creditCollectionViewHeight.constant /= 2
                    self.creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.9)
                }
                
                if !self.viewModel.isThereSimilarTVShow, !self.viewModel.isThereRecommendTVShow {
                    self.viewModel.resetMovieHeaderState()
                    self.creditCollectionViewHeight.constant /= 2
                    self.creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.9)
                }
                
                if let header = event.element?.supplementaryView as? TMDBMovieLikeThisHeaderView {
                    if !self.viewModel.isThereSimilarTVShow {
                        header.segmentControl.removeSegment(at: 0, animated: false)
                        header.segmentControl.selectedSegmentIndex = 0
                    } else if !self.viewModel.isThereRecommendTVShow {
                        header.segmentControl.removeSegment(at: 1, animated: false)
                    }
                    
                    self.viewModel.resetMovieHeaderState()

                } else if let header = event.element?.supplementaryView as? TMDBCreditHeaderView {
                    if !self.viewModel.isThereCast {
                        header.segmentControl.removeSegment(at: 0, animated: false)
                        header.segmentControl.selectedSegmentIndex = 0
                    } else if !self.viewModel.isThereCrew {
                        header.segmentControl.removeSegment(at: 1, animated: false)
                    }
                    
                    self.viewModel.resetCreditHeaderState()
                }
            }
            .disposed(by: rx.disposeBag)
        
        creditCollectionView
            .rx
            .modelSelected(CustomElementType.self)
            .subscribe { event in
                if let tvShow = event.element?.identity as? TVShow {
                    self.delegate?.navigateToTVShowDetail(tvShowId: tvShow.id)
                } else if let cast = event.element?.identity as? Cast {
                    self.delegate?.navigateToPersonDetail(personId: cast.id)
                } else if let crew = event.element?.identity as? Crew {
                    self.delegate?.navigateToPersonDetail(personId: crew.id)
                }
            }
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
