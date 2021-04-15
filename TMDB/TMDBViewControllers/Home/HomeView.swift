//
//  HomeView.swift
//  TMDB
//
//  Created by Tuyen Le on 11/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RealmSwift

class HomeView: UIViewController {

    // MARK: - properties
    
    weak var delegate: AppCoordinator?
    
    let viewModel: HomeViewModelProtocol

    let userSetting: TMDBUserSettingProtocol
    
    let popularDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.getPreviewItemCell(at: indexPath)
        (cell as? TMDBPreviewItemCell)?.configure(item: item)
        return cell
    })
    
    let trendingDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.getPreviewItemCell(at: indexPath)
        (cell as? TMDBPreviewItemCell)?.configure(item: item)
        return cell
    })
    
    let movieDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.getPreviewItemCell(at: indexPath)
        (cell as? TMDBPreviewItemCell)?.configure(item: item)
        return cell
    })
    
    let tvshowDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.getPreviewItemCell(at: indexPath)
        (cell as? TMDBPreviewItemCell)?.configure(item: item)
        return cell
    })
    

    // MARK: - views
    @IBOutlet weak var popularCollectionView: LoadIndicatorCollectionView! {
        didSet {
            popularCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            popularCollectionView.register(TMDBPopularHeaderView.self,
                                           forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                           withReuseIdentifier: Constant.Identifier.popularPreviewHeader)
            popularCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                    forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            popularCollectionView.register(UINib(nibName: String(describing: TMDBViewAllItemCell.self), bundle: nil),
                                    forCellWithReuseIdentifier: Constant.Identifier.viewAllCell)
            
            popularDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.popularPreviewHeader,
                                                                       for: indexPath) as! TMDBPopularHeaderView
            }
        }
    }
    @IBOutlet weak var trendingCollectionView: LoadIndicatorCollectionView! {
        didSet {
            trendingCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            trendingCollectionView.register(TMDBTrendHeaderView.self,
                                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                            withReuseIdentifier: Constant.Identifier.trendPreviewHeader)
            trendingCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                    forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            trendingCollectionView.register(UINib(nibName: String(describing: TMDBViewAllItemCell.self), bundle: nil),
                                    forCellWithReuseIdentifier: Constant.Identifier.viewAllCell)
            trendingDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.trendPreviewHeader,
                                                                       for: indexPath) as! TMDBTrendHeaderView
            }
        }
    }
    @IBOutlet weak var movieCollectionView: LoadIndicatorCollectionView! {
        didSet {
            movieCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            movieCollectionView.register(TMDBMovieHeaderView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: Constant.Identifier.moviePreviewHeader)
            movieCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                         forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            movieCollectionView.register(UINib(nibName: String(describing: TMDBViewAllItemCell.self), bundle: nil),
                                         forCellWithReuseIdentifier: Constant.Identifier.viewAllCell)
            movieDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.moviePreviewHeader,
                                                                       for: indexPath) as! TMDBMovieHeaderView
            }
        }
    }
    @IBOutlet weak var tvshowCollectionView: LoadIndicatorCollectionView! {
        didSet {
            tvshowCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.3, heightDimension: 1)
            tvshowCollectionView.register(TMDBTVShowHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader)
            tvshowCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            tvshowCollectionView.register(UINib(nibName: String(describing: TMDBViewAllItemCell.self), bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.viewAllCell)
            tvshowDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader,
                                                                       for: indexPath) as! TMDBTVShowHeaderView
            }
        }
    }
    
    init(userSetting: TMDBUserSettingProtocol, viewModel: HomeViewModelProtocol) {
        self.userSetting = userSetting
        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLanguageAndRegion()
        setupUIBinding()
        
        viewModel.getPopularMovie()
        viewModel.getTrendingToday()
        viewModel.getTopRatedMovie()
        viewModel.getTopRatedTVShow()
        //self.delegate?.navigateToMovieDetail(movieId: 464052)
        //delegate?.navigateToPersonDetail(personId: 59586)
        //delegate?.navigateToTVShowDetail(tvShowId: 107775)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       navigationController?.resetNavBar()
    }
}

extension HomeView {
    func setupUIBinding() {
        // collectionView data source binding
        
        viewModel
            .popularCollectionView
            .bind(to: popularCollectionView.rx.items(dataSource: popularDataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel
            .trendingCollectionView
            .bind(to: trendingCollectionView.rx.items(dataSource: trendingDataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieCollectionView
            .bind(to: movieCollectionView.rx.items(dataSource: movieDataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel
            .tvshowCollectionView
            .bind(to: tvshowCollectionView.rx.items(dataSource: tvshowDataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel
            .popularLoadIndicator
            .bind(to: popularCollectionView.loadIndicator.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        
        // error label
        viewModel
            .popularErrorMessage
            .bind(to: popularCollectionView.errorLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .trendingErrorMessage
            .bind(to: trendingCollectionView.errorLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .movieErrorMessage
            .bind(to: movieCollectionView.errorLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        
        viewModel
            .tvshowErrorMessage
            .bind(to: tvshowCollectionView.errorLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        // segment selection
        popularCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementaryView, _, _ in
                let popularHeader = supplementaryView as? TMDBPopularHeaderView
                popularHeader?
                    .segmentControl
                    .rx
                    .value
                    .changed
                    .asDriver()
                    .drive(onNext: { index in
                        self.popularCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handlePopularSelection(at: index)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        popularCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                let popularItem = self.popularDataSource.sectionModels.first?.items[indexPath.row]
                self.delegate?.navigateWith(obj: popularItem)
            })
            .disposed(by: rx.disposeBag)
        
            
        trendingCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementaryView, _, _ in
                let trendingHeader = supplementaryView as? TMDBTrendHeaderView
                
                trendingHeader?
                    .segmentControl
                    .rx
                    .value
                    .changed
                    .asDriver()
                    .drive(onNext: { index in
                        self.trendingCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handleTrendingSelection(at: index)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        movieCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementaryView, _, _ in
                let movieHeader = supplementaryView as? TMDBMovieHeaderView
                
                movieHeader?
                    .segmentControl
                    .rx
                    .value
                    .changed
                    .asDriver()
                    .drive(onNext: { index in
                        self.movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handleMovieCategorySelection(at: index)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
        
        tvshowCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementaryView, _, _ in
                let movieHeader = supplementaryView as? TMDBTVShowHeaderView
                
                movieHeader?
                    .segmentControl
                    .rx
                    .value
                    .changed
                    .asDriver()
                    .drive(onNext: { index in
                        self.tvshowCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                        self.viewModel.handleTVShowCategorySelection(at: index)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
    }


    // MARK: - configure language and region
    @objc func configureLanguageAndRegion() {
        // language
        let button = UIButton()
        button.setTitle(NSLocale.current.languageCode?.uppercased(), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = Constant.Color.backgroundColor.cgColor
        button.layer.cornerRadius = 5
        button.showsTouchWhenHighlighted = true
        button.rx.controlEvent(.touchUpInside).asObservable().subscribe { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }.disposed(by: rx.disposeBag)

        let languageSetting = UIBarButtonItem(customView: button)

        // region
        if let region = NSLocale.current.regionCode {
            let regionFlag = UIImage(named: "CountryFlags/\(userSetting.countriesCode.first(where: { $0.iso31661 == region })?.name ?? "")")?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFill)?.withRenderingMode(.alwaysOriginal)
            let regionSetting = UIBarButtonItem(image: regionFlag, style: .plain, target: self, action: nil)
            
            regionSetting.rx.tap.asObservable().subscribe { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url)
            }.disposed(by: rx.disposeBag)
            
            
            navigationItem.setRightBarButtonItems([
                languageSetting,
                regionSetting
            ], animated: false)
        }
    }
}
