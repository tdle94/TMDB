//
//  TMDBProductionHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/3/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBProduceByHeaderCell: UICollectionReusableView {
    weak var delegate: TMDBPreviewSegmentControl?
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = NSLocalizedString("Produce by", comment: "")
        }
    }
}
