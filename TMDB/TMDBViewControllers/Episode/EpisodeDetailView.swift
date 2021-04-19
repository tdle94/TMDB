//
//  EpisodeView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/1/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxDataSources
import RealmSwift
import SkeletonView

class EpisodeDetailView: UIViewController {
    var episode: Episode?
    
    var tvShowId: Int?
    
    var viewModel: EpisodeDetailViewModelProtocol
    
    weak var delegate: AppCoordinator?
    
    // MARK: - constraint
    @IBOutlet weak var creditCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var posterImageTop: NSLayoutConstraint!
    
    // MARK: - data source
    let creditDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item)
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
            imageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = imageCollectionView
        }
    }
    
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)

            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBGuestStarHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
                
            
            creditDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                       for: indexPath)
                    
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

        setupBinding()

        if let episode = self.episode, let id = self.tvShowId {
            title = episode.name
            airDateLabel.attributedText = TMDBLabel.setAttributeText(title: NSLocalizedString("Air On", comment: ""), subTitle: episode.airDate)
            titleLabel.setHeader(title: episode.name)
            
            overviewLabel.setAttributeText(episode.overview)
            ratingLabel.rating = episode.voteAverage
            if let path = episode.stillPath, let url = viewModel.userSetting.getImageURL(from: path) {
                posterImage.sd_setImage(with: url)
            }
            scrollView.parallaxHeader.contentView.showAnimatedGradientSkeleton()
            viewModel.getGuestStar(tvShowId: id, seasonNumber: episode.seasonNumber, episodeNumber: episode.episodeNumber)
            viewModel.getImages(tvShowId: id, seasonNumber: episode.seasonNumber, episodeNumber: episode.episodeNumber)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
}

extension EpisodeDetailView {
    func setupBinding() {

        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)

        // bind image collection view
        viewModel
            .images
            .bind(to: imageCollectionView.rx.items(cellIdentifier: Constant.Identifier.cell)) { _, image, cell in
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
                self.scrollView.parallaxHeader.contentView.hideSkeleton()
                self.scrollView.parallaxHeader.dots = event.element?.count ?? 0
            }
            .disposed(by: rx.disposeBag)
        
        imageCollectionView
            .rx
            .didEndDisplayingCell
            .subscribe { _, indexPath in
                guard let index = self.imageCollectionView.indexPathsForVisibleItems.first?.row else {
                    return
                }
                self.scrollView.parallaxHeader.selectDot(at: index)
            }
            .disposed(by: rx.disposeBag)
        
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
    }
}
