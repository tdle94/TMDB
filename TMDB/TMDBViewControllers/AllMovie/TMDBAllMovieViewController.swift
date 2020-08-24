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

    // MARK: - query
    var movieQuery: DiscoverQuery = DiscoverQuery(page: 1)
    
    // MARK: - presentor
    lazy var presenter: TMDBAllMoviePresenter = TMDBAllMoviePresenter(delegate: self)

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
        let filter = UIBarButtonItem(title: NSLocalizedString("Filter", comment: ""),
                                style: .plain,
                                target: self,
                                action: #selector(filterMovies))
        navigationItem.setRightBarButton(filter, animated: false)
        presenter.getAllMovie(query: movieQuery)
    }

    // MARK: - user action
    @objc func filterMovies() {
        coordinate?.presentMovieFilter(delegate: self, movieQuery: movieQuery)
    }
}
