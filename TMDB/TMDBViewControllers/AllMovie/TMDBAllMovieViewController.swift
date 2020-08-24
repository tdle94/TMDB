//
//  AllMovieCollectionView.swift
//  TMDB
//
//  Created by Tuyen Le on 8/12/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllMovieViewController: UIViewController {
    // MARK: - coordinator
    var coordinate: MainCoordinator?

    // MARK: - repository
    var query: DiscoverQuery = DiscoverQuery(page: 1)

    private var totalMovies: Int = 0

    let repository: TMDBRepository = TMDBRepository.share

    // MARK: - data source
    var allMovieDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    weak var footerLoadingView: TMDBFooterLoadingView?
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = CollectionViewLayout.noHeaderTwoItemsPerRowLayout()
            collectionView.register(UINib(nibName: "TMDBFooterLoadingView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constant.Identifier.previewFooter)
            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)

            allMovieDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: collectionView)
            allMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.footerLoadingView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewFooter, for: indexPath) as? TMDBFooterLoadingView
                return self.footerLoadingView
            }
            var snapshot = allMovieDataSource.snapshot()
            snapshot.appendSections([.movie])
            allMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movies", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        view.addSubview(loadingView)
        getAllMovie()
    }

    // MARK: - service
    func getAllMovie() {
        footerLoadingView?.loadingIndicator.startAnimating()
        repository.getAllMovie(query: query) { result in
            self.footerLoadingView?.loadingIndicator.stopAnimating()
            self.loadingView.removeFromSuperview()
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let allMovieResult):
                self.totalMovies = allMovieResult.totalResults
                var snapshot = self.allMovieDataSource.snapshot()
                snapshot.appendItems(Array(allMovieResult.movies))
                self.allMovieDataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
}

extension TMDBAllMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCount = allMovieDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == movieCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), movieCount != totalMovies {
            let page = movieCount / 20 + 1
            query.page = page
            getAllMovie()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = allMovieDataSource.itemIdentifier(for: indexPath) as? Movie else { return }
        coordinate?.navigateToMovieDetail(id: movie.id)
    }
}
