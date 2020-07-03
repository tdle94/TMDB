//
//  TMDBPreviewHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBPreviewSegmentControl: AnyObject {
    func segmentControlSelected(at index: Int, text selected: String)
}

class TMDBPreviewHeaderView: UICollectionReusableView {
    weak var delegate: TMDBPreviewSegmentControl?
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = NSLocalizedString("Popular", comment: "")
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tertiaryColor], for: .selected)
        }
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        delegate?.segmentControlSelected(at: sender.selectedSegmentIndex, text: text)
    }

    func configure(from section: Int) {
        if section == 1 {
            segmentControl.removeSegment(at: 2, animated: false)
            segmentControl.setTitle(NSLocalizedString("Today", comment: ""), forSegmentAt: 0)
            segmentControl.setTitle(NSLocalizedString("This Week", comment: ""), forSegmentAt: 1)
            label.text = NSLocalizedString("Trends", comment: "")
        } else {
            label.text = NSLocalizedString("Popular", comment: "")
            segmentControl.setTitle(NSLocalizedString("Movies", comment: ""), forSegmentAt: 0)
            segmentControl.setTitle(NSLocalizedString("TV Shows", comment: ""), forSegmentAt: 1)
            if segmentControl.numberOfSegments == 2 {
                segmentControl.insertSegment(withTitle: NSLocalizedString("People", comment: ""), at: 2, animated: false)
            }
        }
    }
}

