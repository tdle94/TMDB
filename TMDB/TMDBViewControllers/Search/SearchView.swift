//
//  SearchView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/25/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxOptional

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
        searchController.searchBar.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal),
                                            for: .search,
                                            state: .normal)
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
                
                // bind search result to tableview
                self.viewModel
                    .searchResult
                    .filterNil()
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
                        let maxY = searchResult.searchResultTableView.contentOffset.y + searchResult.searchResultTableView.frame.height
                        let indexPath = searchResult.searchResultTableView.indexPathForRow(at: CGPoint(x: 0, y: maxY))

                        if
                            let text = self.searchController.searchBar.text,
                            indexPath?.row == searchResult.searchResultTableView.numberOfRows(inSection: 0) - 1,
                            !searchResult.footerLoadIndicatorView.isAnimating {

                            searchResult.footerLoadIndicatorView.startAnimating()
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
                            if let item = try self.viewModel.searchResult.value()?[row] {
                                if item.mediaType == "movie" {
                                    self.delegate?.navigateToMovieDetail(movieId: item.id)
                                } else if item.mediaType == "tv" {
                                    self.delegate?.navigateToTVShowDetail(tvShowId: item.id)
                                } else if item.mediaType == "person" {
                                    self.delegate?.navigateToPersonDetail(personId: item.id)
                                }
                            }
                        } catch let error {
                            debugPrint("Problem selecting search result: \(error.localizedDescription)")
                        }
                    }
                    .disposed(by: self.rx.disposeBag)
                
                // bind filter button
                searchResult
                    .filterButtonView
                    .movieButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.viewModel.filter(search: .movie)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                
                searchResult
                    .filterButtonView
                    .tvShowButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.viewModel.filter(search: .tv)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                searchResult
                    .filterButtonView
                    .peopleButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.viewModel.filter(search: .person)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                searchResult
                    .searchResultTableView
                    .rx
                    .willBeginDragging
                    .asDriver()
                    .drive(onNext: {
                        if self.searchController.searchBar.isFirstResponder {
                            self.searchController.searchBar.resignFirstResponder()
                        }
                    })
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
            .throttle(.seconds(1), latest: true, scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty && !$0.trimmingCharacters(in: .whitespaces).isEmpty && !$0.last!.isWhitespace && !$0.first!.isWhitespace }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { query in
                self.search(text: query.identity)
            })
            .disposed(by: rx.disposeBag)

        // stop loading indicator in tableview's footer view

        viewModel
            .searchResult
            .skip(1)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { searchResult in
                self.searchResult?.footerLoadIndicatorView.stopAnimating()
                self.searchResult?.loadBackgroundView.stopAnimating()
                self.searchResult?.filterButtonView.isHidden = false
                if searchResult?.isEmpty ?? false {
                    self.searchResult?.showEmptyLabel(message: NSLocalizedString("No item found", comment: ""))
                } else if searchResult == nil {
                    self.searchResult?.showEmptyLabel(message: "Error getting search result")
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    func search(text: String) {
        if
            self.searchResult?.searchResultTableView.numberOfSections != 0,
            self.searchResult?.searchResultTableView.numberOfRows(inSection: 0) != 0 {
            
            self.searchResult?.searchResultTableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                                                 at: .bottom,
                                                                 animated: true)
        }

        self.searchResult?.loadBackgroundView.startAnimating()
        self.searchResult?.filterButtonView.isHidden = true
        self.searchResult?.emptyLabel.isHidden = true
        self.viewModel.search(text: text)
    }
}
