//
//  TMDBBackdropImageCell.swift
//  TMDB
//
//  Created by Tuyen Le on 09.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class TMDBBackdropImageCell: TMDBImageCell, TMDBCellConfig {

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "NoImage")
    }
    
    func configure(item: Object) {
        guard
            let image = item as? Images,
            let url = userSetting.getImageURL(from: image.filePath) else {
            imageView.image = UIImage(named: "NoImage")
            return
        }

        imageView.sd_setImage(with: url)
    }
}
