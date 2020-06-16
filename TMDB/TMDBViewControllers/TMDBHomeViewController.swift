//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class TMDBHomeViewController: UIViewController {
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, PopularMovie>!

    var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: URLSession.shared as! TMDBSessionProtocol,
                                                                                   urlRequestBuilder: TMDBURLRequestBuilder()),
                                                            localDataSource: TMDBLocalDataSource())

    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePopularCollectionView()
        configureDataSource()
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
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, id in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Popular", for: indexPath) as! PopularItemCell
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath) -> UICollectionReusableView? in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Popular", for: indexPath) as! PopularItemCell
          
          return cell
        }
    }

    func configurePopularCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        collectionView.register(PopularItemCell.self, forCellWithReuseIdentifier: "Popular")
        view.addSubview(collectionView)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.generatePopularLayout()
        }
    }
    
    func generatePopularLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupFractionalWidth = 0.6
        let groupFractionalHeight: Float =  2/3
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
          heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: headerSize, elementKind: "Popular", alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}

class PopularItemCell: UICollectionViewCell {
    let posterImageView: UIImageView

    override init(frame: CGRect) {
        posterImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}

class HeaderView: UICollectionReusableView {
  static let reuseIdentifier = "my pussy"

  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}

extension HeaderView {
  func configure() {
    backgroundColor = .systemBackground

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true

    let inset = CGFloat(10)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
    ])
    label.font = UIFont.preferredFont(forTextStyle: .title3)
  }
}
