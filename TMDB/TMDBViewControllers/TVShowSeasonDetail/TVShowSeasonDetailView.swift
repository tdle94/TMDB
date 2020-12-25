//
//  TVShowSeasonDetailView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class TVShowSeasonDetailView: UIViewController {
    var season: Season?
    
    var tvShowId: Int?
    
    var viewModel: TVShowSeasonDetailViewModelProtocol
    
    weak var delegate: SeasonDetailViewDelegate?
    
    // MARK: - datasource
    let dataSource: RxCollectionViewSectionedReloadDataSource<TVShowSeasonDetailModel> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item.identity)
        return cell as! UICollectionViewCell
    })
    
    let episodeDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Episode>> = RxTableViewSectionedReloadDataSource(configureCell: { dataSource, tableView, indexPath, item in
        let cell: TMDBCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.tvShowEpisodeCell) as? TMDBCustomTableViewCell
        cell?.configure(item: item)
        return cell!
    })

    // MARK: - constraint
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var episodeTableViewHeight: NSLayoutConstraint!
    
    // MARK: - views
    private var creditHeader: TMDBCreditHeaderView?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var numberOfEpisodeLabel: UILabel!
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.2, heightDimension: 0.95)
            } else {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 1)
            }
            
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBCreditHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            
            dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                let creditHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                   withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                                   for: indexPath) as! TMDBCreditHeaderView
                
                if self.creditHeader == nil {
                    creditHeader
                        .segmentControl
                        .rx
                        .value
                        .changed
                        .subscribe { event in
                            guard let index = event.element else {
                                return
                            }
                            
                            self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)

                            if index == 0 {
                                self.viewModel.getSeasonCasts(tvShowId: self.tvShowId!, seasonNumber: self.season!.number)
                            } else {
                                self.viewModel.getSeasonCrews(tvShowId: self.tvShowId!, seasonNumber: self.season!.number)
                            }
                        }
                        .disposed(by: self.rx.disposeBag)
                    
                    self.creditHeader = creditHeader
                }
                
                return creditHeader
            }
        }
    }
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.borderWidth = 1
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
            episodeTableView.register(UINib(nibName: String(describing: TMDBCustomTableViewCell.self), bundle: nil),
                                      forCellReuseIdentifier: Constant.Identifier.tvShowEpisodeCell)
            episodeTableView.rowHeight = 120
            
            episodeDataSource.titleForHeaderInSection = { dataSource, index in
                return NSLocalizedString("Episode", comment: "")
            }
        }
    }
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = backdropImageCollectionView
            scrollView.parallaxHeader.height = ceil(UIScreen.main.bounds.height / 2.7)
            scrollView.parallaxHeader.minimumHeight = 0
        }
    }
    

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()

        if let season = self.season, let id = tvShowId {
            viewModel.getSeasonDetail(tvShowId: id, seasonNumber: season.number)
        }
        
        navigationItem.setBackArrowIcon()
        setupBinding()
        setupViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        episodeTableViewHeight.constant = episodeTableView.contentSize.height
        episodeTableView.layoutIfNeeded()
    }
    
    // MARK: - init
    init(viewModel: TVShowSeasonDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TVShowSeasonDetailView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowSeasonDetailView {
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
        
        // bind season detail
        viewModel
            .season
            .subscribe { event in
                guard let season = event.element else {
                    return
                }
                
                self.title = season.name
                if let path = season.posterPath, let url = self.viewModel.userSetting.getImageURL(from: path) {
                    self.posterImageView.sd_setImage(with: url)
                }

                Observable
                    .just([SectionModel(model: "Episode", items: Array(season.episodes))])
                    .bind(to: self.episodeTableView.rx.items(dataSource: self.episodeDataSource))
                    .disposed(by: self.rx.disposeBag)
            }
            .disposed(by: rx.disposeBag)
        
        
        
        // scrollview binding
        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)
        
        // bind back drop images
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
        
        // bind credit collectionView
        creditCollectionView
            .rx
            .willDisplaySupplementaryView
            .subscribe { event in
                guard let creditHeader = event.element?.supplementaryView as? TMDBCreditHeaderView else {
                    return
                }
                
                if !self.viewModel.isThereCast {
                    creditHeader.segmentControl.removeSegment(at: 0, animated: false)
                } else if !self.viewModel.isThereCrew {
                    creditHeader.segmentControl.removeSegment(at: 1, animated: false)
                }
                
                self.viewModel.resetCreditHeaderState()
            }
            .disposed(by: rx.disposeBag)
        // bind credit collection view
        viewModel
            .credit
            .bind(to: creditCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        // bind labels
        viewModel
            .airDate
            .bind(to: airDateLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .numberOfEpisode
            .bind(to: numberOfEpisodeLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .title
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .overview
            .bind(to: overviewLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
    }
}
