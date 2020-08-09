//
//  TMDBNetworkImageCell.swift
//  TMDB
//
//  Created by Tuyen Le on 09.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class TMDBNetworkImageCell: TMDBImageCell, TMDBCellConfig {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(item: Object) {
        guard
            let networks = item as? Networks,
            let url = userSetting.getImageURL(from: networks.logoPath) else {
            return
        }

        imageView.sd_setImage(with: url)
    }
}
