//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Tuyen Le on 11/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MovieDetailView: UIViewController {
    weak var delegate: MovieDetailViewDelegate?

    var movieId: Int?
    
    let viewModel: MovieDetailViewModelProtocol
    
    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MovieDetailView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - datasource
    let dataSource: RxCollectionViewSectionedReloadDataSource<MovieDetailModel> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item.identity)
        return cell as! UICollectionViewCell
    })
    
    // MARK: - constraints
    
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var runtimeAndReleaseDateTop: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewTop: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewTop: NSLayoutConstraint!
    
    // MARK: - views
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var produceInCountriesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runtimeAndReleaseDate: UILabel!
    @IBOutlet weak var ratingLabel: TMDBCircleUserRating!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var availableLanguagesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout(fractionWidth: 0.2,
                                                                                                      fractionHeight: 1,
                                                                                                      leadingInset: 18,
                                                                                                      scrollBehavior: .continuous)
            productionCompaniesCollectionView.register(TMDBProductionCompanyCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
        }
    }
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.2)
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
                                    self.viewModel.getCasts(movieId: self.movieId!)
                                } else {
                                    self.viewModel.getCrews(movieId: self.movieId!)
                                }
                            }
                            .disposed(by: self.rx.disposeBag)
                    }
                    
                    return creditHeader
                case .MoviesLikeThis(items: _):
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
                                    self.viewModel.getSimilarMovies(movieId: self.movieId!)
                                } else {
                                    self.viewModel.getRecommendMovies(movieId: self.movieId!)
                                }
                            }
                            .disposed(by: self.rx.disposeBag)
                    }
                    return movieHeader
                }
            }
        }
    }
    @IBOutlet weak var reviewAndReleaseTableView: UITableView! {
        didSet {
            reviewAndReleaseTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                               forCellReuseIdentifier: Constant.Identifier.reviewCell)
        }
    }
    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.collectionViewLayout = TMDBKeywordLayout()
            genreCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout()
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.borderWidth = 1
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = backdropImageCollectionView
            scrollView.parallaxHeader.height = ceil(UIScreen.main.bounds.height / 2.7)
            scrollView.parallaxHeader.minimumHeight = 0

            // refresh movie detail
            scrollView
                .rx
                .didEndDecelerating
                .asObservable()
                .subscribe { _ in
                    if let id = self.movieId, self.scrollView.parallaxHeader.refreshControl.isRefreshing {
                        // reset collection view to original form
                        self.reviewAndReleaseTableView.dataSource = nil
                        self.productionCompaniesCollectionView.dataSource = nil
                        self.genreCollectionView.dataSource = nil
                        
                        self.backdropImageCollectionView.scrollToItem(at: .init(item: 0, section: 0), at: .left, animated: true)
                        
                        self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: false)
                        self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
                        
                        let creditHeader = self.creditCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader,
                                                                                       at: IndexPath(row: 0, section: 0)) as? TMDBCreditHeaderView
                        let moreLikeThisHeader = self.creditCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader,
                                                                                             at: IndexPath(row: 0, section: 1)) as? TMDBMovieLikeThisHeaderView
                        moreLikeThisHeader?.setup()
                        creditHeader?.setup()

                        // get movie detail
                        self.scrollView.parallaxHeader.refreshControl.beginRefreshing()
                        self.viewModel.getImages(movieId: id)
                        self.viewModel.getMovieDetail(movieId: id)
                    }
                }
                .disposed(by: rx.disposeBag)
        }
    }
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLoveIcon()
        navigationItem.setBackArrowIcon()
                                         
        self.setupBinding()
        self.setupViewLayout()

        if let id = movieId {
            viewModel.getImages(movieId: id)
            viewModel.getMovieDetail(movieId: id)
        }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        keywordCollectionViewHeight.constant = keywordCollectionView.collectionViewLayout.collectionViewContentSize.height
        genreCollectionViewHeight.constant = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        keywordCollectionView.layoutIfNeeded()
        genreCollectionView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
    }
}

extension MovieDetailView {
    
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

        // movie detail binding
        viewModel
            .movie
            .asObserver()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(
                onNext: { result in
                    if self.scrollView.parallaxHeader.refreshControl.isRefreshing {
                        self.scrollView.parallaxHeader.refreshControl.endRefreshing()
                    }

                    if let posterPath = result.posterPath, let url = self.viewModel.userSetting.getImageURL(from: posterPath) {
                        self.posterImageView.sd_setImage(with: url) { _, _, _, _ in
                            let color = self.posterImageView.image?.getColors()
                            self.posterImageView.layer.borderColor = color?.primary.cgColor
                        }
                    }

                    (self.genreCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = Array(result.genres).map { $0.name }

                    self.ratingLabel.rating = result.voteAverage
                    self.title = result.title
                    
                    Observable<[String]>
                        .just([
                                NSLocalizedString("Review (\(result.reviews?.reviews.count ?? 0))", comment: ""),
                                NSLocalizedString("Release Date (\(result.releaseDates?.results.count ?? 0))", comment: "")
                        ])
                        .bind(to: self.reviewAndReleaseTableView.rx.items(cellIdentifier: Constant.Identifier.reviewCell)) { index, text, cell in
                            cell.textLabel?.setHeader(title: text)
                        }
                        .disposed(by: self.rx.disposeBag)

                    Observable<[ProductionCompany]>
                        .just(Array(result.productionCompanies).filter { $0.logoPath != nil })
                        .bind(to: self.productionCompaniesCollectionView.rx.items(cellIdentifier: Constant.Identifier.imageCell)) { index, productionCompany, cell in
                            (cell as? TMDBProductionCompanyCell)?.configure(item: productionCompany)
                        }
                        .disposed(by: self.rx.disposeBag)
                    
                    Observable<[Genre]>
                        .just(Array(result.genres))
                        .observeOn(MainScheduler.asyncInstance)
                        .bind(to: self.genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { index, genre, cell in
                            (cell as? TMDBKeywordCell)?.configure(item: genre)
                        }
                        .disposed(by: self.rx.disposeBag)
                    
                },
                onError: { error in
                    if self.scrollView.parallaxHeader.refreshControl.isRefreshing {
                        self.scrollView.parallaxHeader.refreshControl.endRefreshing()
                    }
                }).disposed(by: rx.disposeBag)
        // backdrop images binding
        viewModel
            .images
            .bind(to: backdropImageCollectionView.rx.items(cellIdentifier: Constant.Identifier.imageCell)) { _, image, cell in
                (cell as? TMDBBackdropImageCell)?.configure(item: image)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .images
            .subscribe { event in
                self.scrollView.parallaxHeader.carouselView = CarouselView(numberOfDot: event.element?.count ?? 0)
            }
            .disposed(by: rx.disposeBag)
        
        // scrollview binding
        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)
        
        backdropImageCollectionView
            .rx
            .didEndDisplayingCell
            .subscribe { cell, indexPath in
                guard let index = self.backdropImageCollectionView.indexPathsForVisibleItems.first?.row else {
                    return
                }
                self.scrollView.parallaxHeader.carouselView?.selectDot(at: index)
            }
            .disposed(by: rx.disposeBag)
        
        // keyword collectionView binding
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
                guard let keywords = event.element,
                      let layout = self.keywordCollectionView.collectionViewLayout as? TMDBKeywordLayout
                else {
                    return
                }

                layout.texts = Array(keywords).map { $0.name }
            }
            .disposed(by: rx.disposeBag)
        
        // bind review and release tableview
        
        reviewAndReleaseTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                if indexPath.row == 0 {
                    // TODO
                } else {
                    self.delegate?.navigateToReleaseDate(movieId: self.movieId!)
                }
            })
            .disposed(by: rx.disposeBag)
        
        // bind credit collection view

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
                
                if !self.viewModel.isThereSimilarMovie, !self.viewModel.isThereRecommendMovie {
                    self.viewModel.resetMovieHeaderState()
                    self.creditCollectionViewHeight.constant /= 2
                    self.creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.9)
                }
                
                if !self.viewModel.isThereCast, !self.viewModel.isThereCrew {
                    self.viewModel.resetCreditHeaderState()
                    self.creditCollectionViewHeight.constant /= 2
                    self.creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.9)
                }

                if let header = event.element?.supplementaryView as? TMDBMovieLikeThisHeaderView {
                    if !self.viewModel.isThereSimilarMovie {
                        header.segmentControl.removeSegment(at: 0, animated: false)
                        header.segmentControl.selectedSegmentIndex = 0
                    } else if !self.viewModel.isThereRecommendMovie {
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
            .subscribe { item in
                if let movie = item.element?.identity as? Movie {
                    self.delegate?.navigateToMovieDetail(movieId: movie.id)
                } else if let cast = item.element?.identity as? Cast {
                    self.delegate?.navigateToPersonDetail(personId: cast.id)
                } else if let crew = item.element?.identity as? Crew {
                    self.delegate?.navigateToPersonDetail(personId: crew.id)
                }
            }
            .disposed(by: rx.disposeBag)
        
        // bind label
        viewModel
            .status
            .bind(to: statusLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .tagline
            .bind(to: taglineLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .produceInCountries
            .bind(to: produceInCountriesLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .imdb
            .bind(to: imdbLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .belongToCollection
            .bind(to: collectionNameLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .homepage
            .bind(to: homepageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .overview
            .bind(to: overviewLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .title
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .runtimeAndReleaseDate
            .bind(to: runtimeAndReleaseDate.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .originalLanguage
            .bind(to: originalLanguageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .budget
            .bind(to: budgetLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .revenue
            .bind(to: revenueLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .availableLanguage
            .bind(to: availableLanguagesLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        
        // bind constraint
        viewModel
            .productionCompanyCollectionViewTop
            .bind(to: productionCompanyCollectionViewTop.rx.constant)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .productionCompanyCollectionViewHeight
            .bind(to: productionCompanyCollectionViewHeight.rx.constant)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .keywordCollectionViewHeight
            .bind(to: keywordCollectionViewHeight.rx.constant)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .keywordCollectionViewTop
            .bind(to: keywordCollectionViewTop.rx.constant)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .runtimeAndReleaseDateTop
            .bind(to: runtimeAndReleaseDateTop.rx.constant)
            .disposed(by: rx.disposeBag)
    }
}
