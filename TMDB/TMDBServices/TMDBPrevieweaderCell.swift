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
            segmentControl.setTitle(NSLocalizedString("Movies", comment: ""), forSegmentAt: 0)
            segmentControl.setTitle(NSLocalizedString("TV Shows", comment: ""), forSegmentAt: 1)
            segmentControl.setTitle(NSLocalizedString("People", comment: ""), forSegmentAt: 2)
            segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tertiaryColor], for: .selected)
        }
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        delegate?.segmentControlSelected(at: sender.selectedSegmentIndex, text: text)
    }
}

