//
//  EpisodeView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/1/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxDataSources

class EpisodeDetailView: UIViewController {
    var episode: Episode?
    
    var tvShowId: Int?
    
    var viewModel: EpisodeDetailViewModelProtocol
    
    weak var delegate: EpisodeViewDelegate?
    
    // MARK: - constraint
    @IBOutlet weak var creditCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var posterImageTop: NSLayoutConstraint!
    
    // MARK: - data source
    let creditDataSource: RxCollectionViewSectionedReloadDataSource<EpisodeDetailModel> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item.identity)
        return cell as! UICollectionViewCell
    })
    
    // MARK: - views
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: TMDBCircleUserRating!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            posterImage?.roundImage()
            posterImage?.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            imageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = imageCollectionView
            scrollView.parallaxHeader.height = ceil(UIScreen.main.bounds.height / 2.7)
            scrollView.parallaxHeader.minimumHeight = 0
        }
    }
    
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.2, heightDimension: 0.43)
            } else {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.9)
            }

            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBGuestStarHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            
            creditCollectionView
                .rx
                .modelSelected(CustomElementType.self)
                .asDriver()
                .drive(onNext: { item in
                    if let person = item.identity as? Cast {
                        self.delegate?.navigateToPersonDetail(personId: person.id)
                    }
                })
                .disposed(by: rx.disposeBag)
                
            
            creditDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                       for: indexPath) as! TMDBGuestStarHeaderView
                    
            }
        }
    }
    // MARK: - init
    init(viewModel: EpisodeDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: EpisodeDetailView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setBackArrowIcon()
        navigationController?.setNavBar()
        setupBinding()

        if let episode = self.episode, let id = self.tvShowId {
            title = episode.name
            airDateLabel.attributedText = TMDBLabel.setAttributeText(title: NSLocalizedString("Air On", comment: ""), subTitle: episode.airDate)
            titleLabel.setHeader(title: episode.name)
            
            overviewLabel.setAttributeText(title: episode.overview)
            ratingLabel.rating = episode.voteAverage
            if let path = episode.stillPath, let url = viewModel.userSetting.getImageURL(from: path) {
                posterImage.sd_setImage(with: url)
            }
            
            viewModel.getGuestStar(tvShowId: id, seasonNumber: episode.seasonNumber, episodeNumber: episode.episodeNumber)
            viewModel.getImages(tvShowId: id, seasonNumber: episode.seasonNumber, episodeNumber: episode.episodeNumber)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.resetNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavBar()
        scrollView.setToPreviousAlpha(safeAreaInsetTop: view.safeAreaInsets.top,
                                      navigationController: navigationController)
    }
}

extension EpisodeDetailView {
    func setupBinding() {
        if UIDevice.current.userInterfaceIdiom != .pad {
            posterImageTop.constant += scrollView.contentOffset.y/4
        }

        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)

        // bind image collection view
        viewModel
            .images
            .bind(to: imageCollectionView.rx.items(cellIdentifier: Constant.Identifier.imageCell)) { _, image, cell in
                (cell as? TMDBBackdropImageCell)?.configure(item: image)
            }
            .disposed(by: rx.disposeBag)
        
        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .images
            .subscribe { event in
                self.scrollView.parallaxHeader.carouselView = CarouselView(numberOfDot: event.element?.count ?? 0)
            }
            .disposed(by: rx.disposeBag)
        
        imageCollectionView
            .rx
            .didEndDisplayingCell
            .subscribe { _, indexPath in
                guard let index = self.imageCollectionView.indexPathsForVisibleItems.first?.row else {
                    return
                }
                self.scrollView.parallaxHeader.carouselView?.selectDot(at: index)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .credits
            .bind(to: creditCollectionView.rx.items(dataSource: creditDataSource))
            .disposed(by: rx.disposeBag)
        
        creditCollectionView
            .rx
            .willDisplaySupplementaryView
            .asDriver()
            .drive(onNext: { event in
                if !self.viewModel.isThereGuestStar {
                    (event.supplementaryView as? TMDBGuestStarHeaderView)?.segmentControl.removeSegment(at: 0, animated: false)
                    self.viewModel.resetGuestStarHeaderState()
                    self.creditCollectionView.removeFromSuperview()
                }
            })
            .disposed(by: rx.disposeBag)
            
    }
}
