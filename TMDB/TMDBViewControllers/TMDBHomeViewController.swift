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
    var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                                   urlRequestBuilder: TMDBURLRequestBuilder(),
                                                                                   userSetting: TMDBUserSetting()),
                                                            localDataSource: TMDBLocalDataSource(),
                                                            userSetting: TMDBUserSetting())
    // MARK: - collectionview configuration
    enum Section: String, CaseIterable {
        case popular = "Popular"
        case trending = "Trends"
    }

    @IBOutlet weak var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, Object>!

    let imageHandler: (TMDBPreviewItemCell) -> ((Result<Data, Error>) -> Void) = { cell in
        return { result in
            switch result {
            case .success(let data):
                cell.imageView.image = UIImage(data: data)
            case .failure(_):
                cell.imageView.image = UIImage(named: "NoImage")
            }
        }
    }

    lazy var cellProvider: (UICollectionView, IndexPath, Object) -> UICollectionViewCell? = { [unowned self] collectionView, indexPath, popularItem in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
        if let item = popularItem as? Movie {
            cell.title.text = item.originalTitle
            cell.releaseDate.text = item.releaseDate
            self.repository.getPosterImageData(from: item, completion: self.imageHandler(cell))
        } else if let item = popularItem as? TVShow {
            cell.title.text = item.originalName
            cell.releaseDate.text = item.firstAirDate
            self.repository.getPosterImageData(from: item, completion: self.imageHandler(cell))
        } else if let item = popularItem as? People {
            cell.title.text = item.name
            self.repository.getProfileImageData(from: item, completion: self.imageHandler(cell))
        }
        return cell
    }

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePopularCollectionView()
        configureDataSource()
        getPopularMovie()
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
                snapshot.appendItems(Array(popularMovieResult.movies))
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
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
}

extension TMDBHomeViewController: TMDBPreviewSegmentControl {
    // MARK: - collection view interaction
    func popularSegmentControl(at index: Int) {
        if index == 0 {
            getPopularMovie()
        } else if index == 1 {
            getPopularTVShow()
        } else if index == 2 {
            getPopularPeople()
        }
    }
}

extension TMDBHomeViewController {
    // MARK: - collection view configuration
    func configureDataSource() {

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: cellProvider)

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                              withReuseIdentifier: Constant.Identifier.header,
                                                                              for: indexPath) as! TMDBPreviewHeaderView
            header.label.text = "Popular"
            header.delegate = self
          return header
        }

        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.popular])
        dataSource.apply(snapshot)
    }

    func configurePopularCollectionView() {
        collectionView.collectionViewLayout = generateLayout()
        collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
        collectionView.register(UINib(nibName: "TMDBPreviewHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.header)
    }

    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.generatePopularLayout()
        }
    }

    func generatePopularLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Popular", alignment: .top)

        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 18, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}
