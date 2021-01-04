//
//  DiscoverCollectionViewCell.swift
//  TMDB
//
//  Created by Tuyen Le on 1/3/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class DiscoverCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var entityCollectionView: UICollectionView! {
        didSet {
            entityCollectionView.collectionViewLayout = CollectionViewLayout.discoveryEntityLayout()
            entityCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                          forCellWithReuseIdentifier: Constant.Identifier.previewItem)
        }
    }
}
