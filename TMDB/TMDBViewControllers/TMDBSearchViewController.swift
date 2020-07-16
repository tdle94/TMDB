//
//  TMDBSearchViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 11.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBSearchProtocol: AnyObject {
    func navigateToMovieDetail(id: Int)
    func navigateToPersonDetail(id: Int)
    func multiSearch(query: String?, newSearch: Bool)
}

class TMDBSearchViewController: UIViewController {
    var repository: TMDBRepositoryProtocol!

    var coordinate: MainCoordinator?
    
    var page: Int = 1
    
    let searchResultViewController = UIStoryboard(name: "Main",
                                                  bundle: nil).instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbSearchResultViewController) as! TMDBSearchResultViewController

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: searchResultViewController)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.backgroundColor = Constant.Color.backgroundColor
        search.searchBar.tintColor = .black
        search.searchBar.placeholder = NSLocalizedString("Search", comment: "")
        search.delegate = self
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultViewController.tmdbSearchProtocol = self
        view.backgroundColor = Constant.Color.backgroundColor
        definesPresentationContext = true
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: TMDBUserSetting())
        view.backgroundColor = Constant.Color.backgroundColor
        navigationItem.titleView = searchController.searchBar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
}

extension TMDBSearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
}

extension TMDBSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension TMDBSearchViewController: TMDBSearchProtocol {
    func multiSearch(query: String?, newSearch: Bool) {
        guard let query = query ?? searchController.searchBar.text else { return }
        repository.multiSearch(query: query, page: page) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let multiSearchResult):
                self.page += 1
                self.searchResultViewController.updateSnapshot(item: multiSearchResult.results, newSearch: newSearch)
            }
        }
    }

    func navigateToMovieDetail(id: Int) {
        coordinate?.navigateToMovieDetail(id: id)
    }

    func navigateToPersonDetail(id: Int) {
        coordinate?.navigateToPersonDetail(id: id)
    }
}

extension TMDBSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        multiSearch(query: searchBar.text, newSearch: true)
    }
}
