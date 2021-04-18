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
import RealmSwift

class MovieDetailView: UIViewController {
    weak var delegate: AppCoordinator?

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
    
    let movieDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item)
        return cell as! UICollectionViewCell
    })
    
    let creditDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item)
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
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.previewItem)
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
    @IBOutlet weak var movieCollectionView: UICollectionView! {
        didSet {
            movieCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            movieCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            movieCollectionView.register(TMDBMovieLikeThisHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            
            movieDataSource.configureSupplementaryView = {dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                       for: indexPath)
                
            }
        }
    }
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout(fractionWidth: 0.3,
                                                                                                      fractionHeight: 1,
                                                                                                      leadingInset: 18,
                                                                                                      scrollBehavior: .continuous)
            productionCompaniesCollectionView.register(TMDBProductionCompanyCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }

    @IBOutlet weak var reviewAndReleaseTableView: UITableView! {
        didSet {
            reviewAndReleaseTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                               forCellReuseIdentifier: Constant.Identifier.cell)
        }
    }
    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.collectionViewLayout = TMDBKeywordLayout()
            genreCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout()
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
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

            // refresh movie detail
            scrollView
                .rx
                .didEndDecelerating
                .asObservable()
                .subscribe { _ in
                    if let id = self.movieId, self.scrollView.parallaxHeader.refreshControl.isRefreshing {
                        
                        self.backdropImageCollectionView.scrollToItem(at: .init(item: 0, section: 0), at: .left, animated: false)

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
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLoveIcon()
        navigationItem.setBackArrowIcon()
                                         
        self.setupBinding()

        if let id = movieId {
            viewModel.getImages(movieId: id)
            viewModel.getMovieDetail(movieId: id)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        keywordCollectionViewHeight.constant = keywordCollectionView.collectionViewLayout.collectionViewContentSize.height
        genreCollectionViewHeight.constant = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        keywordCollectionView.layoutIfNeeded()
        genreCollectionView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
}

extension MovieDetailView {
    
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
            .movieParser
            .movie
            .asObserver()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(
                onNext: { result in
                    self.scrollView.parallaxHeader.refreshControl.endRefreshing()
                    self.ratingLabel.rating = result.voteAverage
                    self.title = result.title
                })
            .disposed(by: rx.disposeBag)
        
        // poster image url binding
        viewModel
            .movieParser
            .posterURL
            .subscribe(onNext: { url in
                self.posterImageView.sd_setImage(with: url) { _, _, _, _ in
                    let color = self.posterImageView.image?.getColors()
                    self.posterImageView.layer.borderColor = color?.primary.cgColor
                }
            })
            .disposed(by: rx.disposeBag)
        
        // backdrop images binding
        viewModel
            .movieParser
            .images
            .bind(to: backdropImageCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { _, image, cell in
                (cell as? TMDBBackdropImageCell)?.configure(item: image)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .images
            .subscribe { event in
                self.scrollView.parallaxHeader.dots = event.element?.count ?? 0
            }
            .disposed(by: rx.disposeBag)
        
        // scrollview binding
        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)
        
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
        
        // bind release and review tableview
        viewModel
            .movieParser
            .reviewAndRelease
            .bind(to: self.reviewAndReleaseTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, text, cell in
                cell.textLabel?.setHeader(title: text)
            }
            .disposed(by: self.rx.disposeBag)
        
        // bind production companies
        viewModel
            .movieParser
            .productionCompanies
            .bind(to: self.productionCompaniesCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, productionCompany, cell in
                (cell as? TMDBProductionCompanyCell)?.configure(item: productionCompany)
            }
            .disposed(by: self.rx.disposeBag)
        
        // genres collectionView binding
        viewModel
            .movieParser
            .genres
            .bind(to: self.genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, genre, cell in
                (cell as? TMDBKeywordCell)?.configure(item: genre)
            }
            .disposed(by: self.rx.disposeBag)
        
        viewModel
            .movieParser
            .genres
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { genres in
                (self.genreCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = genres.map { $0.name }
            })
            .disposed(by: rx.disposeBag)
        
        // keyword collectionView binding
        viewModel
            .movieParser
            .keywords
            .bind(to: keywordCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { _, keyword, cell in
                (cell as? TMDBKeywordCell)?.configure(item: keyword)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .keywords
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { keywords in
                (self.keywordCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = keywords.map { $0.name }
            })
            .disposed(by: rx.disposeBag)
        
        // bind review and release tableview
        
        reviewAndReleaseTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                if indexPath.row == 0 {
                    self.delegate?.navigateToReview(reviews: self.viewModel.getReviews(movieId: self.movieId!))
                } else {
                    self.delegate?.navigateToReleaseDate(movieId: self.movieId!)
                }
            })
            .disposed(by: rx.disposeBag)
        
        // bind credit collection view

        viewModel
            .movieParser
            .credits
            .bind(to: creditCollectionView.rx.items(dataSource: creditDataSource))
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
                        self.viewModel.handleCreditSelection(at: index, movieId: self.movieId!)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        creditCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.delegate?.navigateWith(obj: self.creditDataSource.sectionModels.first?.items[indexPath.row])
            })
            .disposed(by: rx.disposeBag)
        
        // bind movie collection view
        viewModel
            .movieParser
            .moviesLikeThis
            .bind(to: movieCollectionView.rx.items(dataSource: movieDataSource))
            .disposed(by: rx.disposeBag)
        
        movieCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.delegate?.navigateWith(obj: self.movieDataSource.sectionModels.first?.items[indexPath.row])
            })
            .disposed(by: rx.disposeBag)
        
        movieCollectionView
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
                        self.movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handleMovieLikeThisSelection(at: index, movieId: self.movieId!)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        // bind label
        viewModel
            .movieParser
            .status
            .bind(to: statusLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .tagline
            .bind(to: taglineLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .produceInCountries
            .bind(to: produceInCountriesLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .imdb
            .bind(to: imdbLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .belongToCollection
            .bind(to: collectionNameLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .homepage
            .bind(to: homepageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .overview
            .bind(to: overviewLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .title
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .runtimeAndReleaseDate
            .bind(to: runtimeAndReleaseDate.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .originalLanguage
            .bind(to: originalLanguageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .budget
            .bind(to: budgetLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .revenue
            .bind(to: revenueLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieParser
            .availableLanguage
            .bind(to: availableLanguagesLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        
        // bind constraint
        viewModel
            .movieParser
            .productionCompaniesCollectionViewHeight
            .bind(to: productionCompanyCollectionViewHeight.rx.constant)
            .disposed(by: rx.disposeBag)
    }
}
