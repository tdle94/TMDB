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
    // MARK: - coordinator
    var coordinate: MainCoordinator?

    // MARK: - repository
    let repository: TMDBRepository = TMDBRepository.share

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
            snapshot.appendSections([.movie])
            allTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        view.addSubview(loadingView)
        getAllTVShow(page: 1)
    }

    // MARK: - service
    func getAllTVShow(page: Int) {
        repository.getAllTVShow(query: DiscoverQuery(page: page)) { result in
            self.loadingView.removeFromSuperview()
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let tvShowResult):
                var snapshot = self.allTVShowDataSource.snapshot()
                snapshot.appendItems(Array(tvShowResult.onTV))
                self.allTVShowDataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
}

extension TMDBAllTVShowViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCount = allTVShowDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == movieCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true) {
            let page = movieCount / 20 + 1
            getAllTVShow(page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShow = allTVShowDataSource.itemIdentifier(for: indexPath) as? TVShow else { return }
        coordinate?.navigateToTVShowDetail(tvId: tvShow.id)
    }
}
