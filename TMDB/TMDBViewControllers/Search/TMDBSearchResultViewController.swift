//
//  SearchResultViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 11.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMDBSearchResultViewController: UIViewController {
    weak var tmdbSearchProtocol: TMDBSearchProtocol?
    
    var searchResultDataSource: UITableViewDiffableDataSource<ResultSection, MultiSearch>!
    
    enum ResultSection: String, CaseIterable {
        case result = "Result"
    }

    @IBOutlet weak var loadMoreButton: UIButton! {
        didSet {
            loadMoreButton.setTitle(NSLocalizedString("Load More", comment: ""), for: .normal)
        }
    }
    
    @IBOutlet weak var searchResultTableView: UITableView! {
        didSet {
            searchResultTableView.separatorInset = .zero
            searchResultTableView.register(UINib(nibName: "TMDBCustomTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.searchResultCell)
            searchResultDataSource = UITableViewDiffableDataSource(tableView: searchResultTableView) { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.searchResultCell, for: indexPath) as? TMDBCustomTableViewCell
                cell?.configure(item: item)
                return cell
            }
            
            var snapshot = searchResultDataSource.snapshot()
            snapshot.appendSections([.result])
            searchResultDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func updateSnapshot(item: [MultiSearch], newSearch: Bool) {
        loadMoreButton.isHidden = false
        var snapshot = searchResultDataSource.snapshot()
        if newSearch {
            snapshot.deleteItems(snapshot.itemIdentifiers)
        }
        snapshot.appendItems(item)
        searchResultDataSource.apply(snapshot, animatingDifferences: true)
    }
    @IBAction func loadMoreButtonTap() {
        loadMoreButton.isHidden = true
        tmdbSearchProtocol?.multiSearch(query: nil, newSearch: false)
    }
}

extension TMDBSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = searchResultDataSource.itemIdentifier(for: indexPath) else { return }

        if item.mediaType == "movie" {
            tmdbSearchProtocol?.navigateToMovieDetail(id: item.id)
        } else if item.mediaType == "person" {
            tmdbSearchProtocol?.navigateToPersonDetail(id: item.id)
        } else if item.mediaType == "tv" {
            tmdbSearchProtocol?.navigateToTVShowDetail(id: item.id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
