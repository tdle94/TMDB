//
//  TMDBTrendHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/3/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTrendHeaderCell: UICollectionReusableView {
    weak var delegate: TMDBPreviewSegmentControl?
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = NSLocalizedString("Trends", comment: "")
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tertiaryColor], for: .selected)
            segmentControl.setTitle(NSLocalizedString("Today", comment: ""), forSegmentAt: 0)
            segmentControl.setTitle(NSLocalizedString("This Week", comment: ""), forSegmentAt: 1)
        }
    }
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        delegate?.segmentControlSelected(at: sender.selectedSegmentIndex, text: text)
    }
}
