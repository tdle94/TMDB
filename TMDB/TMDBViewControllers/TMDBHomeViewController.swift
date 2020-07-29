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

    // MARK: - collectionview configuration
    enum Section: String, CaseIterable {
        case popular = "Popular"
        case trending = "Trends"
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            collectionView.register(TMDBTrendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.trendHeader)
            collectionView.register(TMDBPopularHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.popularHeader)
            
            dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }

            dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath -> UICollectionReusableView? in
                if indexPath.section == 0 {
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                 withReuseIdentifier: Constant.Identifier.popularHeader,
                                                                                 for: indexPath) as? TMDBPopularHeaderView
                    header?.delegate = self
                    return header
                }

                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.trendHeader,
                                                                             for: indexPath) as? TMDBTrendHeaderView
                header?.delegate = self
                return header
            }

            var snapshot = dataSource.snapshot()
            snapshot.appendSections([.popular, .trending])
            dataSource.apply(snapshot)
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Object>!

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

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLanguageAndRegion()
        getPopularMovie()
        getTrendingToday()
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
        } else {
            item = dataSource.snapshot().itemIdentifiers(inSection: .trending)[indexPath.row]
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
    func segmentControlSelected(at index: Int, text selected: String) {
        if selected == NSLocalizedString("Today", comment: "") {
            getTrendingToday()
        } else if selected == NSLocalizedString("This Week", comment: "")  {
            getTrendingThisWeek()
        } else if selected == NSLocalizedString("Movies", comment: "") {
            getPopularMovie()
        } else if selected == NSLocalizedString("People", comment: "") {
            getPopularPeople()
        } else {
            getPopularTVShow()
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
        button.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = Constant.Color.backgroundColor.cgColor
        button.layer.cornerRadius = 5
        button.showsTouchWhenHighlighted = true
        let languageSetting = UIBarButtonItem(customView: button)

        // region
        if let region = NSLocale.current.regionCode {
            let regionFlag = UIImage(named: "CountryFlags/\(Constant.countryName[region] ?? "")")?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFill)?.withRenderingMode(.alwaysOriginal)
            let regionSetting = UIBarButtonItem(image: regionFlag, style: .plain, target: self, action: #selector(changeRegion))
            navigationItem.setRightBarButtonItems([
                languageSetting,
                regionSetting
            ], animated: false)
        }
        
    }

    @objc func changeRegion() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func changeLanguage() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

}
