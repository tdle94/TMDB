//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RealmSwift

class TMDBHomeViewController: UIViewController {
    // MARK: - repository
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    lazy var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                                   urlRequestBuilder: TMDBURLRequestBuilder(),
                                                                                   userSetting: self.userSetting),
                                                            localDataSource: TMDBLocalDataSource(),
                                                            userSetting: self.userSetting)
    // MARK: - collectionview configuration
    enum Section: String, CaseIterable {
        case popular = "Popular"
        case trending = "Trends"
    }

    @IBOutlet weak var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, Object>!

    var imageHandler: (TMDBPreviewItemCell) -> ((Result<Data, Error>) -> Void) = { cell in
        return { result in
            switch result {
            case .success(let data):
                cell.imageView.image = UIImage(data: data)
            case .failure(_):
                cell.imageView.image = UIImage(named: "NoImage")
            }
        }
    }

    lazy var cellProvider: (UICollectionView, IndexPath, Object) -> UICollectionViewCell? = { [unowned self] collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
        if let item = item as? Movie ?? (item as? Trending)?.movie {
            cell.title.text = item.originalTitle
            cell.releaseDate.text = item.releaseDate
            self.repository.getPosterImageData(from: item, completion: self.imageHandler(cell))
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            cell.title.text = item.originalName
            cell.releaseDate.text = item.firstAirDate
            self.repository.getPosterImageData(from: item, completion: self.imageHandler(cell))
        } else if let item = item as? People ?? (item as? Trending)?.people {
            cell.title.text = item.name
            self.repository.getProfileImageData(from: item, completion: self.imageHandler(cell))
        }
        return cell
    }

    lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { [unowned self] result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let trendingResult):
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .trending))
            snapshot.appendItems(Array(trendingResult.trending), toSection: .trending)
            self.dataSource.apply(snapshot, animatingDifferences: true) {
                snapshot.reloadSections([.trending])
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: false)
            }
        }
    }

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLanguageAndRegion()
        configurePopularCollectionView()
        configureDataSource()
        getPopularMovie()
        getTrendingToday()
    }
}

extension TMDBHomeViewController {
    // MARK: - collection view make request base on user interaction
    func getPopularMovie() {
        repository.getPopularMovie(page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let popularMovieResult):
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .popular))
                snapshot.appendItems(Array(popularMovieResult.movies), toSection: .popular)
                self.dataSource.apply(snapshot, animatingDifferences: true) {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
                }
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
                self.dataSource.apply(snapshot, animatingDifferences: true) {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
                }
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
                self.dataSource.apply(snapshot, animatingDifferences: true) {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
                }
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

extension TMDBHomeViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(at index: Int, text selected: String) {
        if index == 0 {
            if selected == NSLocalizedString("Today", comment: "") {
                getTrendingToday()
            } else {
                getPopularMovie()
            }
        } else if index == 1 {
            if selected == NSLocalizedString("This Week", comment: "") {
                getTrendingThisWeek()
            } else {
                getPopularTVShow()
            }
        } else {
            getPopularPeople()
        }
    }
}

extension TMDBHomeViewController {
    // MARK: - configure navigation item
    func configureLanguageAndRegion() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        button.setTitle(userSetting.language?.uppercased(), for: .normal)
        button.addTarget(self, action: #selector(changeLanguageAndRegion), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = Constant.Color.tabBarSelectedTextColor.cgColor
        button.layer.cornerRadius = 5
        button.showsTouchWhenHighlighted = true
        let languageSetting = UIBarButtonItem(customView: button)
        navigationItem.setRightBarButton(languageSetting, animated: false)
    }

    @objc func changeLanguageAndRegion() {
        coordinator?.navigateToCountryVC()
    }

    // MARK: - collection view configuration
    func configureDataSource() {

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                              withReuseIdentifier: Constant.Identifier.popularHeader,
                                                                              for: indexPath) as? TMDBPreviewHeaderView
            header?.delegate = self

            if indexPath.section == 1 {
                header?.segmentControl.removeSegment(at: 2, animated: false)
                header?.segmentControl.setTitle(NSLocalizedString("Today", comment: ""), forSegmentAt: 0)
                header?.segmentControl.setTitle(NSLocalizedString("This Week", comment: ""), forSegmentAt: 1)
                header?.label.text = NSLocalizedString("Trends", comment: "")
            }
            return header
        }

        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.popular, .trending])
        dataSource.apply(snapshot)
    }

    func configurePopularCollectionView() {
        collectionView.collectionViewLayout = generateLayout()
        collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
        collectionView.register(UINib(nibName: "TMDBPreviewHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.popularHeader)
    }

    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            return self.generatePopularLayout()
        }
    }

    func generatePopularLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 18, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}
