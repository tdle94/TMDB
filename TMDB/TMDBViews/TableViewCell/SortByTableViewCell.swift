//
//  SortByTableViewCell.swift
//  TMDB
//
//  Created by Tuyen Le on 1/6/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

class SortByTableViewCell: UITableViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                accessoryType = .checkmark
            } else {
                accessoryType = .none
            }
        }
    }
    
    func setup(at indexPath: IndexPath, tableView: UITableView, filter: DiscoverQuery) {
        
        var selectedIndexPath: IndexPath?
        
        switch filter.sortBy {
        case .popularity(let order):
            if indexPath.section == 0 && indexPath.row == 0 && order == .ascending || indexPath.section == 0 && indexPath.row == 1 && order == .descending {
                selectedIndexPath = indexPath
            }
        case .voteAverage(let order):
            if indexPath.section == 1 && indexPath.row == 0 && order == .ascending || indexPath.section == 1 && indexPath.row == 1 && order == .descending {
               selectedIndexPath = indexPath
            }
        case .voteCount(let order):
            if indexPath.section == 2 && indexPath.row == 0 && order == .ascending || indexPath.section == 2 && indexPath.row == 1 && order == .descending {
                selectedIndexPath = indexPath
            }
        case .none:
            break
        }
        
        if selectedIndexPath != nil {
            isSelected = true
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }

        if indexPath.row == 0 {
            textLabel?.setAttributeText(title: "Ascending")
        } else {
            textLabel?.setAttributeText(title: "Descending")
        }
    }
}
