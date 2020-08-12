//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import SDWebImage.SDImageCache
import RealmSwift

class TMDBHomeViewController: UIViewController {
    // MARK: - repository
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    var repository: TMDBRepository = TMDBRepository.share

    // MARK: - data source
    var dataSource: TMDBCollectionDataSource!

    // MARK: - ui
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            collectionView.register(TMDBTrendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.trendPreviewHeader)
            collectionView.register(TMDBPopularHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.popularPreviewHeader)
            collectionView.register(TMDBMovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.moviePreviewHeader)
            collectionView.register(TMDBTVShowHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader)
            
            dataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: collectionView)
            dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
                let header: TMDBPreviewHeaderView?
                if indexPath.section == 0 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.popularPreviewHeader,
                                                                             for: indexPath) as? TMDBPopularHeaderView

                } else if indexPath.section == 1 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.trendPreviewHeader,
                                                                             for: indexPath) as? TMDBTrendHeaderView
                } else if indexPath.section == 2 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.moviePreviewHeader,
                                                                             for: indexPath) as? TMDBMovieHeaderView
                } else {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader,
                                                                             for: indexPath) as? TMDBTVShowHeaderView
                }
                header?.delegate = self
                return header
            }

            var snapshot = dataSource.snapshot()
            snapshot.appendSections([.popular, .trending, .movie, .tvShow])
            dataSource.apply(snapshot)
        }
    }

    lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let trendingResult):
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .trending))
            snapshot.appendItems(Array(trendingResult.trending), toSection: .trending)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: true)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let tvShowResult):
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .tvShow))
            snapshot.appendItems(Array(tvShowResult.onTV), toSection: .tvShow)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 3), at: .centeredHorizontally, animated: true)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let movieResult):
            var snaphot = self.dataSource.snapshot()
            snaphot.deleteItems(snaphot.itemIdentifiers(inSection: .movie))
            snaphot.appendItems(Array(movieResult.movies), toSection: .movie)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .centeredHorizontally, animated: true)
            self.dataSource.apply(snaphot, animatingDifferences: true)
        }
    }

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLanguageAndRegion()
        getPopularMovie()
        getTrendingToday()
        getTopRatedMovie()
        getTopRatedTVShow()
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
}

extension TMDBHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: Object
        if indexPath.section == 0 {
            item = dataSource.snapshot().itemIdentifiers(inSection: .popular)[indexPath.row]
        } else if indexPath.section == 1 {
            item = dataSource.snapshot().itemIdentifiers(inSection: .trending)[indexPath.row]
        } else if indexPath.section == 2 {
            item = dataSource.snapshot().itemIdentifiers(inSection: .movie)[indexPath.row]
        } else {
            item = dataSource.snapshot().itemIdentifiers(inSection: .tvShow)[indexPath.row]
        }

        if let item = item as? Movie ?? (item as? Trending)?.movie {
            coordinator?.navigateToMovieDetail(id: item.id)
        } else if let item = item as? People ?? (item as? Trending)?.people {
            coordinator?.navigateToPersonDetail(id: item.id)
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            coordinator?.navigateToTVShowDetail(tvId: item.id)
        }
    }
}

extension TMDBHomeViewController {
    // MARK: - service request
    func getPopularMovie() {
        repository.getPopularMovie(page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let popularMovieResult):
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .popular))
                snapshot.appendItems(Array(popularMovieResult.movies), toSection: .popular)
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }

    func getTopRatedMovie() {
        repository.getTopRateMovie(page: 1, completion: movieHandler)
    }

    func getUpcomingMovie() {
        repository.getUpcomingMovie(page: 1, completion: movieHandler)
    }

    func getNowPlayingMovie() {
        repository.getNowPlayingMovie(page: 1, completion: movieHandler)
    }

    func getPopularTVShow() {
        repository.getPopularOnTV(page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let popularTVShow):
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .popular))
                snapshot.appendItems(Array(popularTVShow.onTV), toSection: .popular)
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    func getTVShowAiringToday() {
        repository.getTVShowAiringToday(page: 1, completion: tvShowHandler)
    }

    func getTVShowOnTheAir() {
        repository.getTVShowOnTheAir(page: 1, completion: tvShowHandler)
    }

    func getTopRatedTVShow() {
        repository.getTopRatedTVShow(page: 1, completion: tvShowHandler)
    }

    func getPopularPeople() {
        repository.getPopularPeople(page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let popularPeopleResult):
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .popular))
                snapshot.appendItems(Array(popularPeopleResult.peoples), toSection: .popular)
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }

    func getTrendingThisWeek() {
        repository.getTrending(time: .week, type: .all, completion: trendingHandler)
    }
    
    func getTrendingToday() {
        repository.getTrending(time: .today, type: .all, completion: trendingHandler)
    }
}

// MARK: - segment control user interaction
extension TMDBHomeViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        if selected == NSLocalizedString("Today", comment: "") {
            getTrendingToday()
        } else if selected == NSLocalizedString("This Week", comment: "")  {
            getTrendingThisWeek()
        } else if selected == NSLocalizedString("Movies", comment: "") {
            getPopularMovie()
        } else if selected == NSLocalizedString("People", comment: "") {
            getPopularPeople()
        } else if selected == NSLocalizedString("TV Shows", comment: "") {
            getPopularTVShow()
        } else if selected == NSLocalizedString("Top Rated", comment: "") {
            if header is TMDBMovieHeaderView {
                getTopRatedMovie()
            } else {
                getTopRatedTVShow()
            }
        } else if selected == NSLocalizedString("Upcoming", comment: "") {
            getUpcomingMovie()
        } else if selected == NSLocalizedString("Now Playing", comment: "") {
            getNowPlayingMovie()
        } else if selected == NSLocalizedString("Air Today", comment: "") {
            getTVShowAiringToday()
        } else if selected == NSLocalizedString("On The Air", comment: "") {
            getTVShowOnTheAir()
        }
    }
}

// MARK: - language and region
extension TMDBHomeViewController {
    // MARK: - configure language and region
    @objc func configureLanguageAndRegion() {
        navigationItem.rightBarButtonItems = nil

        // language
        let button = UIButton()
        button.setTitle(NSLocale.current.languageCode?.uppercased(), for: .normal)
        button.addTarget(self, action: #selector(openSetting), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = Constant.Color.backgroundColor.cgColor
        button.layer.cornerRadius = 5
        button.showsTouchWhenHighlighted = true
        let languageSetting = UIBarButtonItem(customView: button)

        // region
        if let region = NSLocale.current.regionCode {
            let regionFlag = UIImage(named: "CountryFlags/\(userSetting.countriesCode.first(where: { $0.iso31661 == region })?.name ?? "")")?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFill)?.withRenderingMode(.alwaysOriginal)
            let regionSetting = UIBarButtonItem(image: regionFlag, style: .plain, target: self, action: #selector(openSetting))
            navigationItem.setRightBarButtonItems([
                languageSetting,
                regionSetting
            ], animated: false)
        }
        
    }

    @objc func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
