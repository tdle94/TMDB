//
//  TMDBTelevisionViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllTVShowViewController: UIViewController {
    // MARK: - query
    var tvQuery: DiscoverQuery = DiscoverQuery(page: 1)

    // MARK: - coordinator
    var coordinate: MainCoordinator?

    // MARK: - presenter
    lazy var presenter: TMDBAllTVShowPresenter = TMDBAllTVShowPresenter(delegate: self)

    // MARK: - data source
    var allTVShowDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    weak var footerLoadingView: TMDBFooterLoadingView?
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = CollectionViewLayout.noHeaderTwoItemsPerRowLayout()
            collectionView.register(UINib(nibName: "TMDBFooterLoadingView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constant.Identifier.previewFooter)
            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)

            allTVShowDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: collectionView)
            allTVShowDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.footerLoadingView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewFooter, for: indexPath) as? TMDBFooterLoadingView
                return self.footerLoadingView
            }
            var snapshot = allTVShowDataSource.snapshot()
            snapshot.appendSections([.tvShow])
            allTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("TV Shows", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        let filter = UIBarButtonItem(title: NSLocalizedString("Filter", comment: ""),
                                style: .plain,
                                target: self,
                                action: #selector(filterMovies))
        navigationItem.setRightBarButton(filter, animated: false)
        view.addSubview(loadingView)
        presenter.getAllTVShow(tvShowQuery: tvQuery)
    }

    // MARK: - user action
    @objc func filterMovies() {
        coordinate?.presentFilter(delegate: self, query: tvQuery, choice: .tvShow)
    }
}
