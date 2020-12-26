//
//  SearchView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/25/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class SearchView: UIViewController {
    
    var viewModel: SearchViewViewModelProtocol
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: - views
    var searchController: UISearchController
    
    private var searchResult: SearchResultView?
    
    // MARK: - init
    init(searchController: UISearchController, viewModel: SearchViewViewModelProtocol) {
        self.viewModel = viewModel
        self.searchController = searchController
        self.searchResult = searchController.searchResultsController as? SearchResultView
        super.init(nibName: String(describing: SearchView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.Color.backgroundColor
        navigationItem.searchController = searchController
        title = NSLocalizedString("Search", comment: "")
        searchController.searchBar.placeholder = NSLocalizedString("Search Bar", comment: "")
        (searchController.searchBar.value(forKey: "searchField") as? UITextField)?.textColor = Constant.Color.backgroundColor
        searchController.searchBar.tintColor = Constant.Color.backgroundColor
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchController.searchBar.becomeFirstResponder()
        navigationController?.resetNavBar()
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
    }
}

extension SearchView {
    func setupBinding() {
        searchController
            .rx
            .willPresent
            .take(1)
            .asSingle()
            .subscribe(onSuccess: {
                guard let searchResult = self.searchResult else {
                    return
                }
                
                searchResult.searchResultTableView.dataSource = nil
                
                // bind search result to tableview
                self.viewModel
                    .searchResult
                    .bind(to: searchResult.searchResultTableView.rx.items(cellIdentifier: Constant.Identifier.searchResultCell)) { index, item, cell in
                        (cell as? TMDBCustomTableViewCell)?.configure(item: item)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                // search new page when user scroll to bottom of tableview
                searchResult
                    .searchResultTableView
                    .rx
                    .didScroll
                    .asDriver()
                    .drive(onNext: { _ in
                        let maxY = searchResult.searchResultTableView.contentOffset.y + searchResult.searchResultTableView.frame.height - 50
                        let indexPath = searchResult.searchResultTableView.indexPathForRow(at: CGPoint(x: 0, y: maxY))

                        if
                            let text = self.searchController.searchBar.text,
                            indexPath?.row == searchResult.searchResultTableView.numberOfRows(inSection: 0) - 1,
                            !searchResult.loadingIndicatorView.isAnimating {

                            searchResult.loadingIndicatorView.startAnimating()
                            self.viewModel.search(text: text)

                        }


                    })
                    .disposed(by: self.rx.disposeBag)
                
                // navigate when user tap on search result
                searchResult
                    .searchResultTableView
                    .rx
                    .itemSelected
                    .subscribe { event in
                        guard let row = event.element?.row else {
                            return
                        }
                        
                        do {
                            let item = try self.viewModel.searchResult.value()[row]
                            if item.mediaType == "movie" {
                                self.delegate?.navigateToMovieDetail(movieId: item.id)
                            } else if item.mediaType == "tv" {
                                self.delegate?.navigateToTVShowDetail(tvShowId: item.id)
                            }
                        } catch let error {
                            debugPrint("Problem selecting search result: \(error.localizedDescription)")
                        }
                    }
                    .disposed(by: self.rx.disposeBag)
                
            })
            .disposed(by: rx.disposeBag)
        
        // search when user tap search button
        searchController
            .searchBar
            .rx
            .searchButtonClicked
            .subscribe { _ in
                guard
                    let text = self.searchController.searchBar.text,
                    !text.isEmpty
                else {
                    return
                }

                self.search(text: text)
            }
            .disposed(by: rx.disposeBag)
        
        // search when user is typing in searchbar
        searchController
            .searchBar
            .rx
            .text
            .orEmpty
            .debounce(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .subscribe { query in
                guard
                    let text = query.element?.identity,
                    !text.isEmpty
                else {
                    return
                }

                self.search(text: text)
            }
            .disposed(by: rx.disposeBag)
        
        // reset search property when tap cancel
        searchController
            .searchBar
            .rx
            .cancelButtonClicked
            .subscribe { _ in
                self.viewModel.resetSearch()
            }
            .disposed(by: rx.disposeBag)

        // stop loading indicator in tableview's footer view
        viewModel
            .searchResult
            .subscribe { _ in
                self.searchResult?.loadingIndicatorView.stopAnimating()
            }
            .disposed(by: rx.disposeBag)
    }
    
    func search(text: String) {
        if
            self.searchResult?.searchResultTableView.numberOfSections != 0,
            self.searchResult?.searchResultTableView.numberOfRows(inSection: 0) != 0 {
            
            self.searchResult?.searchResultTableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                                                 at: .top,
                                                                 animated: true)
        }

        self.viewModel.search(text: text)
    }
}
