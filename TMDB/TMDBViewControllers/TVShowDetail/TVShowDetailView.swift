//
//  TVShowDetailView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class TVShowDetailView: UIViewController {
    var tvShowId: Int?
    
    var delegate: TVShowDetailViewDelegate?
    
    let viewModel: TVShowDetailViewModelProtocol
    
    // MARK: - constraint
    
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewHeight: NSLayoutConstraint!
    
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
    @IBOutlet weak var reviewTableView: UITableView! {
        didSet {
            reviewTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.reviewCell)
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
                self.keywordCollectionViewHeight.constant = self.keywordCollectionView.collectionViewLayout.collectionViewContentSize.height
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

                (self.genreCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = Array(tvShowDetail.genres).map { $0.name }

                // genre collection view
                Observable<[Genre]>
                    .just(Array(tvShowDetail.genres))
                    .bind(to: self.genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { _, genre, cell in
                        (cell as? TMDBKeywordCell)?.configure(item: genre)
                        self.genreCollectionViewHeight.constant = self.genreCollectionView.collectionViewLayout.collectionViewContentSize.height
                    }
                    .disposed(by: self.rx.disposeBag)
                
                
                // review table
                Observable<[String]>
                    .just([NSLocalizedString("Review", comment: "")])
                    .bind(to: self.reviewTableView.rx.items(cellIdentifier: Constant.Identifier.reviewCell)) { _, text, cell in
                        cell.textLabel?.setHeader(title: text + " (\(tvShowDetail.reviews?.reviews.count ?? 0))")
                    }
                    .disposed(by: self.rx.disposeBag)
            }
            .disposed(by: rx.disposeBag)
        
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
