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
import RealmSwift

class TVShowSeasonDetailView: UIViewController {
    var season: Season?
    
    var tvShowId: Int?
    
    var viewModel: TVShowSeasonDetailViewModelProtocol
    
    weak var delegate: AppCoordinator?
    
    // MARK: - datasource
    let creditDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item)
        return cell as! UICollectionViewCell
    })
    
    let episodeDataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Episode>> = RxTableViewSectionedReloadDataSource(configureCell: { dataSource, tableView, indexPath, item in
        let cell: TMDBCustomTableViewCell? = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell) as? TMDBCustomTableViewCell
        cell?.configure(item: item)
        return cell!
    })

    // MARK: - constraint
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var episodeTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeight: NSLayoutConstraint!
    
    // MARK: - views

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var numberOfEpisodeLabel: UILabel!
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
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.borderWidth = 1
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
            episodeTableView.register(UINib(nibName: String(describing: TMDBCustomTableViewCell.self), bundle: nil),
                                      forCellReuseIdentifier: Constant.Identifier.cell)
            episodeTableView.rowHeight = 120
            
            episodeDataSource.titleForHeaderInSection = { dataSource, index in
                return NSLocalizedString("Episode", comment: "")
            }
            
            episodeTableView
                .rx
                .itemSelected
                .asDriver()
                .drive(onNext: { indexPath in
                    self.delegate?.navigateToEpisodeDetail(episode: self.episodeDataSource.sectionModels.first!.items[indexPath.row],
                                                           tvShowId: self.tvShowId!)
                })
                .disposed(by: rx.disposeBag)
        }
    }
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = backdropImageCollectionView
        }
    }
    

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()

        if let season = self.season, let id = tvShowId {
            episodeTableView.showAnimatedGradientSkeleton()
            airDateLabel.showAnimatedGradientSkeleton()
            numberOfEpisodeLabel.showAnimatedGradientSkeleton()
            titleLabel.showAnimatedGradientSkeleton()
            overviewLabel.showAnimatedGradientSkeleton()
            scrollView.parallaxHeader.contentView.showAnimatedGradientSkeleton()
            posterImageView.showAnimatedGradientSkeleton()
            
            viewModel.getSeasonDetail(tvShowId: id, seasonNumber: season.number)
        }
        
        navigationItem.setBackArrowIcon()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.resetNavBar()
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowSeasonDetailView {

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
                
                self.episodeTableView.hideSkeleton()
                self.airDateLabel.hideSkeleton()
                self.numberOfEpisodeLabel.hideSkeleton()
                self.titleLabel.hideSkeleton()
                self.overviewLabel.hideSkeleton()
                self.scrollView.parallaxHeader.contentView.hideSkeleton()
                self.posterImageView.hideSkeleton()

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
        
        // bind credit collectionView
        
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
                        self.viewModel.handleCreditSelection(at: index, tvshowId: self.tvShowId!, seasonNumber: self.season!.number)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
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
