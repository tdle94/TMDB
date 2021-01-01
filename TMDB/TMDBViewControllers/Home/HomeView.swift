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

class HomeView: UIViewController {

    // MARK: - properties
    
    weak var delegate: HomeViewDelegate?
    
    let viewModel: HomeViewModelProtocol

    let userSetting: TMDBUserSettingProtocol
    
    let dataSource: RxCollectionViewSectionedReloadDataSource<HomeModel> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item.identity)
        return cell as! UICollectionViewCell
    })
    

    // MARK: - views
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                collectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.2, heightDimension: 0.3)
            } else {
                collectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            }

            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            collectionView.register(TMDBTrendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.trendPreviewHeader)
            collectionView.register(TMDBPopularHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.popularPreviewHeader)
            collectionView.register(TMDBMovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.moviePreviewHeader)
            collectionView.register(TMDBTVShowHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader)
            
            // item select
            collectionView
                .rx
                .modelSelected(CustomElementType.self).subscribe { item in
                    if let movie = item.element?.identity as? Movie ?? (item.element?.identity as? Trending)?.movie {
                        self.delegate?.navigateToMovieDetail(movieId: movie.id)
                    } else if let tvShow = item.element?.identity as? TVShow ?? (item.element?.identity as? Trending)?.tv {
                        self.delegate?.navigateToTVShowDetail(tvShowId: tvShow.id)
                    } else if let person = item.element?.identity as? People ?? (item.element?.identity as? Trending)?.people {
                        self.delegate?.navigateToPersonDetail(personId: person.id)
                    }
                }
                .disposed(by: rx.disposeBag)

            
            // suplementary view
            dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                switch dataSource.sectionModels[indexPath.section] {
                case .Popular(items: _):
                    return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: Constant.Identifier.popularPreviewHeader,
                                                                           for: indexPath) as! TMDBPopularHeaderView
                case .Trending(items: _):
                    return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: Constant.Identifier.trendPreviewHeader,
                                                                           for: indexPath) as! TMDBTrendHeaderView
                case .Movie(items: _):
                    return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: Constant.Identifier.moviePreviewHeader,
                                                                           for: indexPath) as! TMDBMovieHeaderView
                case .TVShow(items: _):
                    return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader,
                                                                           for: indexPath) as! TMDBTVShowHeaderView
                }
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
        //self.delegate?.navigateToMovieDetail(movieId: 464052)
        //delegate?.navigateToPersonDetail(personId: 59586)
        //delegate?.navigateToTVShowDetail(tvShowId: 107775)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
}

extension HomeView {
    func setupUIBinding() {
        // collectionView data source binding
        viewModel
            .collectionViewSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        collectionView
            .rx
            .willDisplaySupplementaryView
            .subscribe { event in
                guard let supplementaryView = event.element?.supplementaryView else {
                    return
                }

                if let popularHeader = supplementaryView as? TMDBPopularHeaderView, popularHeader.segmentControl.selectedSegmentIndex == -1  {
                    popularHeader.segmentControl.selectedSegmentIndex = 0
                    popularHeader
                        .segmentControl
                        .rx
                        .value
                        .subscribe { event in
                            guard let el = event.element, let segment = Int(el.description) else {
                                return
                            }

                            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)

                            if segment == 0 {
                                self.viewModel.getPopularMovie()
                            } else if segment == 1 {
                                self.viewModel.getPopularTVShow()
                            } else {
                                self.viewModel.getPopularPeople()
                            }
                            
                        }.disposed(by: self.rx.disposeBag)

                } else if let trendingHeader = supplementaryView as? TMDBTrendHeaderView, trendingHeader.segmentControl.selectedSegmentIndex == -1 {
                    trendingHeader.segmentControl.selectedSegmentIndex = 0
                    trendingHeader
                        .segmentControl
                        .rx
                        .value
                        .subscribe { event in
                            guard let el = event.element, let segment = Int(el.description) else {
                                return
                            }
                            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: true)

                            if segment == 0 {
                                self.viewModel.getTrendingToday()
                            } else {
                                self.viewModel.getTrendingThisWeek()
                            }
                        
                        }
                        .disposed(by: self.rx.disposeBag)

                } else if let movieHeader = supplementaryView as? TMDBMovieHeaderView, movieHeader.segmentControl.selectedSegmentIndex == -1 {
                    movieHeader.segmentControl.selectedSegmentIndex = 0
                    movieHeader
                        .segmentControl
                        .rx
                        .value
                        .subscribe { event in
                            guard let el = event.element, let segment = Int(el.description) else {
                                return
                            }

                            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .centeredHorizontally, animated: true)

                            if segment == 0 {
                                self.viewModel.getTopRatedMovie()
                            } else if segment == 1 {
                                self.viewModel.getNowPlayingMovie()
                            } else {
                                self.viewModel.getUpcomingMovie()
                            }
                        
                        }
                        .disposed(by: self.rx.disposeBag)

                } else if let tvShowHeader = supplementaryView as? TMDBTVShowHeaderView, tvShowHeader.segmentControl.selectedSegmentIndex == -1 {
                    tvShowHeader.segmentControl.selectedSegmentIndex = 0
                    tvShowHeader
                        .segmentControl
                        .rx
                        .value
                        .subscribe { event in
                            guard let el = event.element, let segment = Int(el.description) else {
                                return
                            }

                            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 3), at: .centeredHorizontally, animated: true)

                            if segment == 0 {
                                self.viewModel.getTopRatedTVShow()
                            } else if segment == 1 {
                                self.viewModel.getTVShowAiringToday()
                            } else {
                                self.viewModel.getTVShowOnTheAir()
                            }

                        }
                        .disposed(by: self.rx.disposeBag)
                }
            }
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
