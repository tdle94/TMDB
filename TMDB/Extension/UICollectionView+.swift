//
//  UICollectionView+.swift
//  TMDB
//
//  Created by Tuyen Le on 2/19/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

extension UICollectionView {
    func getPreviewItemCell(at indexPath: IndexPath) -> UICollectionViewCell {
        return indexPath.row == 0
            ? dequeueReusableCell(withReuseIdentifier: Constant.Identifier.viewAllCell, for: indexPath)
            : dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath)
    }
}
