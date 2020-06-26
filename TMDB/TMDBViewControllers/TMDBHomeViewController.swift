//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import SDWebImage
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

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            collectionView.register(UINib(nibName: "TMDBPreviewHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Object>!

    lazy var cellProvider: (UICollectionView, IndexPath, Object) -> UICollectionViewCell? = { collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
        var url: URL?

        if let item = item as? Movie ?? (item as? Trending)?.movie {
            cell.title.text = item.originalTitle
            cell.releaseDate.text = item.releaseDate
            if let path = item.posterPath {
                url = self.repository.getImageURL(from: path)
            }
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            cell.title.text = item.originalName
            cell.releaseDate.text = item.firstAirDate
            if let path = item.posterPath {
                url = self.repository.getImageURL(from: path)
            }
        } else if let item = item as? People ?? (item as? Trending)?.people {
            cell.title.text = item.name
            if let path = item.profilePath {
                url = self.repository.getImageURL(from: path)
            }
        }

        cell.imageView.sd_setImage(with: url, placeholderImage: nil, options: .init(rawValue: 0), completed: { _, error, _, _ in
            if error != nil {
                cell.imageView.image = UIImage(named: "NoImage")
            }
            cell.imageLoadingIndicator.stopAnimating()
        })
        return cell
    }

    lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let trendingResult):
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .trending))
            snapshot.appendItems(Array(trendingResult.trending), toSection: .trending)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: false)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureLanguageAndRegion()
        getTrendingToday()
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
        }
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
                snapshot.reloadSections([.popular])
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
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
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
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
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
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
    @objc func configureLanguageAndRegion() {
        navigationItem.rightBarButtonItems = nil

        // refresh and go select popular movie in a region
        let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as! TMDBPreviewHeaderView
        header.segmentControl.selectedSegmentIndex = 0
        header.segmentControlAction(header.segmentControl)

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
            let regionFlag = UIImage(named: "CountryFlags/\(Constant.countryName[region] ?? "")")?.resize(newWidth: 30)?.withRenderingMode(.alwaysOriginal)
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

    // MARK: - collection view configuration
    func configureDataSource() {

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                              withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                              for: indexPath) as? TMDBPreviewHeaderView
            header?.delegate = self

            if indexPath.section == 1 {
                header?.segmentControl.removeSegment(at: 2, animated: false)
                header?.segmentControl.setTitle(NSLocalizedString("Today", comment: ""), forSegmentAt: 0)
                header?.segmentControl.setTitle(NSLocalizedString("This Week", comment: ""), forSegmentAt: 1)
                header?.label.text = NSLocalizedString("Trends", comment: "")
            } else {
                header?.label.text = NSLocalizedString("Popular", comment: "")
                header?.segmentControl.setTitle(NSLocalizedString("Movies", comment: ""), forSegmentAt: 0)
                header?.segmentControl.setTitle(NSLocalizedString("TV Shows", comment: ""), forSegmentAt: 1)
                if header?.segmentControl.numberOfSegments == 2 {
                    header?.segmentControl.insertSegment(withTitle: NSLocalizedString("People", comment: ""), at: 2, animated: false)
                }
            }
            return header
        }

        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.popular, .trending])
        dataSource.apply(snapshot)
    }
}
