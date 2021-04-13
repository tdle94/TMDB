//
//  TMDBProductionCompanyCell.swift
//  TMDB
//
//  Created by Tuyen Le on 12/11/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RealmSwift
import UIKit

class TMDBProductionCompanyCell: TMDBImageCell, TMDBCellConfig {
    func configure(item: Object) {
        guard
            let logoPath = item.imagePath,
            let url = userSetting.getImageURL(from: logoPath) else {
            return
        }
        imageView.sd_setImage(with: url)
        imageView.image?.sd_resizedImage(with: bounds.size, scaleMode: .fill)
    }
}
