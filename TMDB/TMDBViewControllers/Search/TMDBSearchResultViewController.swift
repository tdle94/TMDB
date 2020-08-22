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

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var searchResultDataSource: TMDBTableDataSource!

    @IBOutlet weak var loadMoreButton: UIButton! {
        didSet {
            loadMoreButton.setTitle(NSLocalizedString("Load More", comment: ""), for: .normal)
        }
    }
    
    @IBOutlet weak var searchResultTableView: UITableView! {
        didSet {
            searchResultTableView.separatorInset = .zero
            searchResultTableView.register(UINib(nibName: "TMDBCustomTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.searchResultCell)
            searchResultDataSource = TMDBTableDataSource(cellIdentifier: Constant.Identifier.searchResultCell, tableView: searchResultTableView)

            var snapshot = searchResultDataSource.snapshot()
            snapshot.appendSections([.searchResult])
            searchResultDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func updateSnapshot(multiSearchResult: MultiSearchResult) {
        if multiSearchResult.totalResults != multiSearchResult.results.count + searchResultDataSource.snapshot().itemIdentifiers.count {
            loadMoreButton.isHidden = false
        }
        loadingIndicator.stopAnimating()

        var snapshot = searchResultDataSource.snapshot()
        snapshot.appendItems(multiSearchResult.results)
        searchResultDataSource.apply(snapshot, animatingDifferences: true)
    }

    func removeSearchResult() {
        loadMoreButton.isHidden = true
        loadingIndicator.startAnimating()
        var snapshot = searchResultDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .searchResult))
        searchResultDataSource.apply(snapshot, animatingDifferences: true)
    }

    @IBAction func loadMoreButtonTap() {
        loadMoreButton.isHidden = true
        loadingIndicator.startAnimating()
        tmdbSearchProtocol?.multiSearch(query: nil, newSearch: false)
    }
}

extension TMDBSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = searchResultDataSource.itemIdentifier(for: indexPath) as? MultiSearch else { return }

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
