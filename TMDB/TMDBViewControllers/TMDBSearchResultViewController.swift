//
//  SearchResultViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 11.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewController: UIViewController {
    
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()
    
    enum ResultSection: String, CaseIterable {
        case result = "Result"
    }
    
    var searchResultDataSource: UITableViewDiffableDataSource<ResultSection, MultiSearch>!
    
    @IBOutlet weak var searchResultTableView: UITableView! {
        didSet {
            searchResultDataSource = UITableViewDiffableDataSource(tableView: searchResultTableView) { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.searchResultCell, for: indexPath)
                cell.textLabel?.text = item.originalTitle ?? item.originalName ?? item.name
                cell.detailTextLabel?.text = item.releaseDate ?? item.firstAirDate
                
                if let path = item.profilePath {
                    cell.imageView?.sd_setImage(with: self.userSetting.getImageURL(from: path))
                }
                return cell
            }
            
            var snapshot = searchResultDataSource.snapshot()
            snapshot.appendSections([.result])
            searchResultDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
