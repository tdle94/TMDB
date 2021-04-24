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
    
    private var tvshowLoadingIndicatorView: UICollectionReusableView?
    private var movieLoadingIndicatorView: UICollectionReusableView?
    
    let errorLabel = UILabel()
    
    @IBOutlet weak var entityCollectionView: UICollectionView! {
        didSet {
            entityCollectionView.backgroundView = UIView()
            entityCollectionView.backgroundView?.addSubview(errorLabel)

            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            errorLabel.centerXAnchor.constraint(equalTo: entityCollectionView.backgroundView!.centerXAnchor).isActive = true
            errorLabel.centerYAnchor.constraint(equalTo: entityCollectionView.backgroundView!.centerYAnchor).isActive = true
            
            entityCollectionView.collectionViewLayout = CollectionViewLayout.discoveryEntityLayout()
            entityCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.previewItem)

            entityCollectionView.register(UINib(nibName: String(describing: LoadingIndicatorView.self), bundle: nil),
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                          withReuseIdentifier: Constant.Identifier.cell)

            movieDataSource.configureSupplementaryView = { _, collectionView, _, indexPath in
                if let view = self.movieLoadingIndicatorView {
                    return view
                }
                
                self.movieLoadingIndicatorView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                                 withReuseIdentifier: Constant.Identifier.cell,
                                                                                                 for: indexPath)
                return self.movieLoadingIndicatorView!
            }
            
            tvShowDataSource.configureSupplementaryView = { _, collectionView, _, indexPath in
                if let view = self.tvshowLoadingIndicatorView {
                    return view
                }
                
                self.tvshowLoadingIndicatorView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                                  withReuseIdentifier: Constant.Identifier.cell,
                                                                                                  for: indexPath)
                
                return self.tvshowLoadingIndicatorView!
            }
        }
    }
}
