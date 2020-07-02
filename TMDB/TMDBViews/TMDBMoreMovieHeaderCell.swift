//
//  TMDBMoreMovieHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/1/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMoreMovieHeaderCell: UICollectionReusableView {
    weak var delegate: TMDBPreviewSegmentControl?
    
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = NSLocalizedString("More", comment: "")
        }
    }

    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tertiaryColor], for: .selected)
            segmentControl.setTitle(NSLocalizedString("Similar", comment: ""), forSegmentAt: 0)
            segmentControl.setTitle(NSLocalizedString("Recommend", comment: ""), forSegmentAt: 1)
        }
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        delegate?.segmentControlSelected(at: sender.selectedSegmentIndex, text: text)
    }
}
