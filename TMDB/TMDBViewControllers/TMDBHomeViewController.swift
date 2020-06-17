//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class TMDBHomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, PopularMovie>!

    var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                                   urlRequestBuilder: TMDBURLRequestBuilder()),
                                                            localDataSource: TMDBLocalDataSource())

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePopularCollectionView()
        configureDataSource()
        getPopularMovie()
    }

    enum Section: String, CaseIterable {
        case popularMovie = "Popular Movies"
        case trending = "Trends"
    }

    func getPopularMovie() {
        repository.getPopularMovie(page: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let popularMovieResult):
                    var snapshot = NSDiffableDataSourceSnapshot<Section, PopularMovie>()
                    snapshot.appendSections([Section.popularMovie])
                    snapshot.appendItems(Array(popularMovieResult.movies))
                    self.dataSource.apply(snapshot)
                }
            }
        }
    }
}

extension TMDBHomeViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, popularMovie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
            cell.title.text = popularMovie.originalTitle
            cell.releaseDate.text = popularMovie.releaseDate
            if let posterPath = popularMovie.posterPath {
                self.repository.getImageData(from: posterPath) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            cell.imageView.image = UIImage(data: data)
                        case .failure(_):
                            cell.imageView.image = UIImage(named: "NoImage")
                        }
                    }
                }
            }
            return cell
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                              withReuseIdentifier: Constant.Identifier.header,
                                                                              for: indexPath) as! TMDBPreviewHeaderView
            header.label.text = "Popular"
          return header
        }
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
