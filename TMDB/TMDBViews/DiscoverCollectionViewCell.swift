//
//  DiscoverCollectionViewCell.swift
//  TMDB
//
//  Created by Tuyen Le on 1/3/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxDataSources

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    let movieDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Movie>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as! TMDBPreviewItemCell
        cell.configure(item: item)
        
        return cell
    })
    
    
    let tvShowDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, TVShow>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as! TMDBPreviewItemCell
        cell.configure(item: item)
        
        return cell
    })
    
    weak var movieLoadingIndicatorView: LoadingIndicatorView?
    
    weak var tvShowLoadingIndicatorView: LoadingIndicatorView?
    
    @IBOutlet weak var entityCollectionView: UICollectionView! {
        didSet {
            entityCollectionView.collectionViewLayout = CollectionViewLayout.discoveryEntityLayout()
            entityCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.previewItem)

            entityCollectionView.register(UINib(nibName: String(describing: LoadingIndicatorView.self), bundle: nil),
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                          withReuseIdentifier: Constant.Identifier.loading)

            movieDataSource.configureSupplementaryView = { _, collectionView, _, indexPath in
                self.movieLoadingIndicatorView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                                 withReuseIdentifier: Constant.Identifier.loading,
                                                                                                 for: indexPath) as? LoadingIndicatorView
                return self.movieLoadingIndicatorView!
            }
            
            tvShowDataSource.configureSupplementaryView = { _, collectionView, _, indexPath in
                self.tvShowLoadingIndicatorView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                                  withReuseIdentifier: Constant.Identifier.loading,
                                                                                                  for: indexPath) as? LoadingIndicatorView
                return self.tvShowLoadingIndicatorView!
            }
        }
    }
}
