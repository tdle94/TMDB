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
    
    let userSetting: TMDBUserSettingProtocol
    
    init(viewModel: MovieDetailViewModelProtocol, userSetting: TMDBUserSettingProtocol) {
        self.viewModel = viewModel
        self.userSetting = userSetting
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
    private var movieLikeThisHeaderView: TMDBMovieLikeThisHeaderView?
    private var creditHeaderView: TMDBCreditHeaderView?

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
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            }
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBCreditHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            creditCollectionView.register(TMDBMovieLikeThisHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.moviePreviewHeader)
            dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                let header: TMDBPreviewHeaderView
                
                if indexPath.section == 0 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                             for: indexPath) as! TMDBCreditHeaderView
                    if self.creditHeaderView == nil {
                        header
                            .segmentControl
                            .rx
                            .selectedSegmentIndex
                            .changed
                            .subscribe { event in
                                let index = Int(event.element!.description)

                                if index == 0 {
                                    self.viewModel.getCasts(movieId: self.movieId!)
                                } else {
                                    self.viewModel.getCrews(movieId: self.movieId!)
                                }
                                
                                self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                            }
                            .disposed(by: self.rx.disposeBag)
                    }
                    
                    self.creditHeaderView = header as? TMDBCreditHeaderView
                } else {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.moviePreviewHeader,
                                                                             for: indexPath) as! TMDBMovieLikeThisHeaderView
                    if self.movieLikeThisHeaderView == nil {
                        header
                            .segmentControl
                            .rx
                            .selectedSegmentIndex
                            .changed
                            .subscribe { event in
                                let index = Int(event.element!.description)

                                if index == 0 {
                                    self.viewModel.getSimilarMovies(movieId: self.movieId!)
                                } else {
                                    self.viewModel.getRecommendMovies(movieId: self.movieId!)
                                }
                                
                                self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: true)
                            }
                            .disposed(by: self.rx.disposeBag)
                    }
                    
                    self.movieLikeThisHeaderView = header as? TMDBMovieLikeThisHeaderView
                    
                }
                return header
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

            scrollView.rx.didEndDecelerating.asObservable().subscribe { _ in
                if let id = self.movieId, self.scrollView.parallaxHeader.refreshControl.isRefreshing {
                    self.backdropImageCollectionView.scrollToItem(at: .init(item: 0, section: 0), at: .left, animated: true)
                    self.scrollView.parallaxHeader.refreshControl.beginRefreshing()
                    self.viewModel.getImages(movieId: id)
                    self.scrollView.parallaxHeader.refreshControl.endRefreshing()
                }
            }.disposed(by: rx.disposeBag)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        keywordCollectionViewHeight.constant = keywordCollectionView.collectionViewLayout.collectionViewContentSize.height
        genreCollectionViewHeight.constant = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        creditCollectionView.layoutIfNeeded()
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
        navigationItem.leftBarButtonItem?.rx.tap.subscribe { _ in
            self.delegate?.navigateBack()
        }.disposed(by: rx.disposeBag)

        // movie detail binding
        viewModel
            .movie
            .asObserver()
            .subscribe(
                onNext: { result in
                    var releaseDate = ""
                    var producedInCountriesAbbreviation = Array(result.productionCountries).map { $0.ios31661 }.joined(separator: ", ")
                    let producedInCountries = Array(result.productionCountries).map { $0.name }

                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal

                    if let posterPath = result.posterPath, let url = self.userSetting.getImageURL(from: posterPath) {
                        self.posterImageView.sd_setImage(with: url) { _, _, _, _ in
                            let color = self.posterImageView.image?.getColors()
                            self.posterImageView.layer.borderColor = color?.primary.cgColor
                        }
                    }
                    
                    if let date = result.releaseDate, !date.isEmpty {
                        releaseDate = "\u{2022} \(date)"
                    }
                    
                    if let tagline = result.tagline {
                        self.taglineLabel.setAttributeText(title: tagline)
                    }
                   
                    if Array(result.productionCompanies).filter({ $0.logoPath != nil }).isEmpty {
                        self.productionCompanyCollectionViewHeight.constant = 0
                        self.productionCompanyCollectionViewTop.constant = 0
                    }
                    
                    
                    if !producedInCountriesAbbreviation.isEmpty {
                        producedInCountriesAbbreviation = "(\(producedInCountriesAbbreviation))"
                    }
                    
                    if !producedInCountries.isEmpty {
                        self.produceInCountriesLabel.setAttributeText(title: NSLocalizedString("Produced In", comment: ""),
                                                                      subTitle: producedInCountries.joined(separator: ", "))
                    }
                    
                    if !(result.imdbId?.isEmpty ?? true) {
                        self.imdbLabel.setAttributeText(title: "IMDB", subTitle: result.imdbId)
                    }
                    
                    if !(result.belongToCollection?.name.isEmpty ?? true) {
                        self.imdbLabel.setAttributeText(title: NSLocalizedString("Collection", comment: ""), subTitle: result.belongToCollection?.name)
                    }
                    
                    if !(result.homepage?.isEmpty ?? true) {
                        self.homepageLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""), subTitle: result.homepage)
                    }
                    
                    self.title = result.originalTitle
                    self.ratingLabel.rating = result.voteAverage
                    self.overviewLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                            paragraph: result.overview ?? "")
                    self.titleLabel.setHeader(title: result.originalTitle)
                    self.runtimeAndReleaseDate.setAttributeText(title: "\(result.runtime / 60)h \(result.runtime % 60)mins \(releaseDate) \(producedInCountriesAbbreviation)")
                    self.statusLabel.setAttributeText(title: NSLocalizedString("Status", comment: ""),
                                                      subTitle: result.status)
                    self.originalLanguageLabel.setAttributeText(title: NSLocalizedString("Original Language", comment: ""),
                                                                subTitle: self.userSetting.languagesCode.first(where: { $0.iso6391 == result.originalLanguage })?.name)
                    self.budgetLabel.setAttributeText(title: NSLocalizedString("Budget", comment: ""),
                                                      subTitle: "$\(numberFormatter.string(from: NSNumber(value: result.budget)) ?? "0.0")")
                    
                    self.revenueLabel.setAttributeText(title: NSLocalizedString("Revenue", comment: ""),
                                                       subTitle: "$\(numberFormatter.string(from: NSNumber(value: result.revenue)) ?? "0.0")")
                    self.availableLanguagesLabel.setAttributeText(title: NSLocalizedString("Available Lanuages", comment: ""),
                                                                  subTitle: Array(result.spokenLanguages).map { $0.name }.joined(separator: ", "))

                    Observable<[String]>
                        .just([
                                NSLocalizedString("Review (\(result.reviews?.reviews.count ?? 0))", comment: ""),
                            NSLocalizedString("Release Date (\(result.releaseDates?.results.count ?? 0))", comment: "")
                        ])
                        .bind(to: self.reviewAndReleaseTableView.rx.items(cellIdentifier: Constant.Identifier.reviewCell)) { index, text, cell in
                            cell.textLabel?.text = text
                            cell.textLabel?.font = UIFont(name: "Circular-Book", size: 14)
                        }
                        .disposed(by: self.rx.disposeBag)

                    Observable<[ProductionCompany]>
                        .just(Array(result.productionCompanies).filter { $0.logoPath != nil })
                        .bind(to: self.productionCompaniesCollectionView.rx.items(cellIdentifier: Constant.Identifier.imageCell)) { index, productionCompany, cell in
                            (cell as? TMDBProductionCompanyCell)?.configure(item: productionCompany)
                        }
                        .disposed(by: self.rx.disposeBag)
                    
                },
                onError: { error in
                
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
                guard let images = event.element else {
                    return
                }
                self.scrollView.parallaxHeader.carouselView = CarouselView(numberOfDot: images.count)
            }
            .disposed(by: rx.disposeBag)
        
        // scrollview binding
        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)
        
        backdropImageCollectionView.rx.didEndDisplayingCell.subscribe { _, indexPath in
            guard let index = self.backdropImageCollectionView.indexPathsForVisibleItems.first?.row else {
                return
            }
            self.scrollView.parallaxHeader.carouselView?.selectDot(at: index)
        }.disposed(by: rx.disposeBag)
        
        // keyword collectionView binding
        viewModel
            .keywords
            .bind(to: keywordCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { index, keyword, cell in
                (cell as? TMDBKeywordCell)?.configure(keyword: keyword)
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

                if keywords.isEmpty {
                    self.keywordCollectionViewHeight.constant = 0
                    self.keywordCollectionViewTop.constant = 0
                    self.runtimeAndReleaseDateTop.constant = 0
                }
                layout.texts = Array(keywords).map { $0.name }
            }
            .disposed(by: rx.disposeBag)
        
        // genre collectionView binding
        viewModel
            .genres
            .bind(to: genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { index, genre, cell in
                let keyword = Keyword()
                keyword.name = genre.name
                (cell as? TMDBKeywordCell)?.configure(keyword: keyword)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .genres
            .asObserver()
            .subscribe { event in
                guard let genre = event.element,
                      let layout = self.genreCollectionView.collectionViewLayout as? TMDBKeywordLayout
                else {
                    return
                }
                layout.texts = genre.map { $0.name }
            }
            .disposed(by: rx.disposeBag)
        
        reviewAndReleaseTableView
            .rx
            .itemSelected
            .subscribe { indexPath in
                // TODO: navigate to either review or release view controller
            }
            .disposed(by: rx.disposeBag)
        
        // bind credit collection view

        viewModel
            .credits
            .map { sectionModels in
                guard sectionModels.count == 1 else {
                    if sectionModels[0].items.isEmpty, sectionModels[1].items.isEmpty {
                        self.creditCollectionViewHeight.constant = 0
                        return []
                    } else if sectionModels[0].items.isEmpty {
                        self.creditCollectionViewHeight.constant /= 2.5
                        self.creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.4, heightDimension: 0.9)
                        return [sectionModels[1]]
                    } else if sectionModels[1].items.isEmpty {
                        self.creditCollectionViewHeight.constant /= 2.5
                        self.creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.4, heightDimension: 0.9)
                        return [sectionModels[0]]
                    }
                    return sectionModels
                }
                
                guard let section = sectionModels.first else {
                    return []
                }
                
                switch section {
                case .Credits(items: _):
                    return self.dataSource.sectionModels.count == 2
                        ? [section, self.dataSource.sectionModels[1]]
                        : [section]
                case .MoviesLikeThis(items: _):
                    return [
                        self.dataSource.sectionModels[0],
                        section
                    ]
                }
            }
            .bind(to: creditCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        
        creditCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(2)
            .subscribe { event in
                if let header = event.element?.supplementaryView as? TMDBMovieLikeThisHeaderView {
                    if !self.viewModel.isThereCast, !self.viewModel.isThereCrew {
                        header.segmentControl.removeAllSegments()
                    } else if !self.viewModel.isThereSimilarMovie {
                        header.segmentControl.removeSegment(at: 0, animated: false)
                        header.segmentControl.selectedSegmentIndex = 0
                    } else if !self.viewModel.isThereRecommendMovie {
                        header.segmentControl.removeSegment(at: 1, animated: false)
                    }
                } else if let header = event.element?.supplementaryView as? TMDBCreditHeaderView {
                    if !self.viewModel.isThereCast, !self.viewModel.isThereCrew {
                        header.segmentControl.removeAllSegments()
                    } else if !self.viewModel.isThereCast {
                        header.segmentControl.removeSegment(at: 0, animated: false)
                        header.segmentControl.selectedSegmentIndex = 0
                    } else if !self.viewModel.isThereCrew {
                        header.segmentControl.removeSegment(at: 1, animated: false)
                    }
                }
            }
            .disposed(by: rx.disposeBag)
    }
}
