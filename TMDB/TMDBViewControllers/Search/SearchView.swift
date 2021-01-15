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
    
    var searchViewModel: SearchViewModelProtocol
    
    var discoveryViewModel: DiscoveryViewModelProtocol
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: - views
    var searchController: UISearchController
    
    private var searchResult: SearchResultView?
    
    var filterBarButton = UIBarButtonItem(title: "Filter", style: .plain, target: nil, action: nil)

    @IBOutlet weak var discoveryChoiceView: DiscoveryFilterButtonView!
    @IBOutlet weak var discoveryCollectionView: UICollectionView! {
        didSet {
            discoveryCollectionView.collectionViewLayout = CollectionViewLayout.discoveryLayout()
            discoveryCollectionView.register(UINib(nibName: String(describing: DiscoverCollectionViewCell.self), bundle: nil),
                                             forCellWithReuseIdentifier: Constant.Identifier.displayAllCell)
        }
    }
    
    // MARK: - init
    init(searchController: UISearchController,
         searchViewModel: SearchViewModelProtocol,
         discoveryViewModel: DiscoveryViewModelProtocol) {
        self.searchViewModel = searchViewModel
        self.discoveryViewModel = discoveryViewModel
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

        searchController.setup(withPlaceholder: NSLocalizedString("Search Bar", comment: ""))

        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar

        filterBarButton.tintColor = Constant.Color.backgroundColor
        navigationItem.setRightBarButton(filterBarButton,animated: true)
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
}

extension SearchView: ApplyFilterDelegate {
    var visibleRow: Int? {
        return discoveryCollectionView.indexPathsForVisibleItems.first?.row
    }

    var query: DiscoverQuery {
        return visibleRow == 0 ? discoveryViewModel.movieQuery : discoveryViewModel.tvShowQuery
    }

    func applyFilter(query: DiscoverQuery?) {
        guard let row = visibleRow else {
            return
        }

        let indexPath = IndexPath(row: row, section: 0)

        (discoveryCollectionView.cellForItem(at: indexPath) as? DiscoverCollectionViewCell)?.entityCollectionView.scrollToItem(at: indexPath,
                                                                                                                               at: .bottom,
                                                                                                                               animated: true)
        
        if row == 0 {
            discoveryViewModel.applyMovieFilter(query: query)
        } else {
            discoveryViewModel.applyTVShowFilter(query: query)
        }

    }
}

extension SearchView {
    func setupBinding() {
        // bind filter bar button
        filterBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.delegate?.presentFilterView(applyFilter: self)
            })
            .disposed(by: rx.disposeBag)

        // bind discover collection view
        Observable<[Int]>
            .just([0,1])
            .bind(to: discoveryCollectionView.rx.items(cellIdentifier: Constant.Identifier.displayAllCell)) { section, _, cell  in
                let discoverCell = cell as! DiscoverCollectionViewCell
                
                if discoverCell.entityCollectionView.numberOfItems(inSection: 0) != 0 {
                    // only allow to load first time
                    return
                }

                if section == 0 {
                    // get first page initially
                    self.discoveryViewModel.getAllMovie(nextPage: false)
                    
                    
                    // bind inner collection view
                    self.discoveryViewModel
                        .movie
                        .filterNil()
                        .bind(to: discoverCell.entityCollectionView.rx.items(dataSource: discoverCell.movieDataSource))
                        .disposed(by: self.rx.disposeBag)
                    
                    self.discoveryViewModel
                        .movie
                        .asDriver(onErrorJustReturn: nil)
                        .drive(onNext: { result in
                            discoverCell.errorLabel.isHidden = result != nil
                            discoverCell.movieLoadingIndicatorView?.loadingIndicator.stopAnimating()
                        })
                        .disposed(by: self.rx.disposeBag)
                    
                    discoverCell
                        .entityCollectionView
                        .rx
                        .itemSelected
                        .asDriver()
                        .drive(onNext: { indexPath in
                            if let movieId = discoverCell.movieDataSource.sectionModels.first?.items[indexPath.row].id {
                                self.delegate?.navigateToMovieDetail(movieId: movieId)
                            }
                        })
                        .disposed(by: self.rx.disposeBag)
                    
                    // paginate, when user scroll to bottom of collectionview
                    discoverCell
                        .entityCollectionView
                        .rx
                        .didScroll
                        .asDriver()
                        .drive(onNext: {

                            let bottomEdge = discoverCell.entityCollectionView.contentOffset.y + discoverCell.entityCollectionView.frame.size.height

                            if bottomEdge >= discoverCell.entityCollectionView.contentSize.height, !(discoverCell.movieLoadingIndicatorView?.loadingIndicator.isAnimating ?? true) {
                                discoverCell.movieLoadingIndicatorView?.loadingIndicator.startAnimating()
                                self.discoveryViewModel.getAllMovie(nextPage: true)
                            }
                        })
                        .disposed(by: self.rx.disposeBag)

                } else if section == 1 {
                    // get first page initially
                    self.discoveryViewModel.getAllTVShow(nextPage: false)
                    
                    // bind inner collection view
                    self.discoveryViewModel
                        .tvShow
                        .filterNil()
                        .bind(to: discoverCell.entityCollectionView.rx.items(dataSource: discoverCell.tvShowDataSource))
                        .disposed(by: self.rx.disposeBag)
                    
                    self.discoveryViewModel
                        .tvShow
                        .asDriver(onErrorJustReturn: nil)
                        .drive(onNext: { result in
                            discoverCell.errorLabel.isHidden = result != nil
                            discoverCell.tvShowLoadingIndicatorView?.loadingIndicator.stopAnimating()
                        })
                        .disposed(by: self.rx.disposeBag)
                    
                    discoverCell
                        .entityCollectionView
                        .rx
                        .itemSelected
                        .asDriver()
                        .drive(onNext: { indexPath in
                            if let tvShowId = discoverCell.tvShowDataSource.sectionModels.first?.items[indexPath.row].id {
                                self.delegate?.navigateToTVShowDetail(tvShowId: tvShowId)
                            }
                        })
                        .disposed(by: self.rx.disposeBag)
      
                    
                    // paginate, when user scroll to bottom of collectionview
                    discoverCell
                        .entityCollectionView
                        .rx
                        .didScroll
                        .asDriver()
                        .drive(onNext: {
                            let bottomEdge = discoverCell.entityCollectionView.contentOffset.y + discoverCell.entityCollectionView.frame.size.height
                            
                            if bottomEdge >= discoverCell.entityCollectionView.contentSize.height, !(discoverCell.tvShowLoadingIndicatorView?.loadingIndicator.isAnimating ?? true) {
                                discoverCell.tvShowLoadingIndicatorView?.loadingIndicator.startAnimating()
                                self.discoveryViewModel.getAllTVShow(nextPage: true)
                            }
                        })
                        .disposed(by: self.rx.disposeBag)
                }
            }
            .disposed(by: rx.disposeBag)

        discoveryCollectionView
            .rx
            .didEndDisplayingCell
            .asDriver()
            .drive(onNext: { event in
                self.discoveryChoiceView.select(at: event.at.row)
            })
            .disposed(by: rx.disposeBag)
        
        // bind discover choice button view
        discoveryChoiceView
            .movieButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.discoveryCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                          at: .centeredHorizontally,
                                                          animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        discoveryChoiceView
            .tvShowButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.discoveryCollectionView.scrollToItem(at: IndexPath(row: 1, section: 0),
                                                          at: .centeredHorizontally,
                                                          animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        // bind when search controller is presented once
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
                self.searchViewModel
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
                            self.searchViewModel.search(text: text)

                        }
                    })
                    .disposed(by: self.rx.disposeBag)
                
                // navigate when user tap on search result
                searchResult
                    .searchResultTableView
                    .rx
                    .itemSelected
                    .asDriver()
                    .drive(onNext: { indexPath in
                        if let item = try! self.searchViewModel.searchResult.value()?[indexPath.row] {
                            if item.mediaType == "movie" {
                                self.delegate?.navigateToMovieDetail(movieId: item.id)
                            } else if item.mediaType == "tv" {
                                self.delegate?.navigateToTVShowDetail(tvShowId: item.id)
                            } else if item.mediaType == "person" {
                                self.delegate?.navigateToPersonDetail(personId: item.id)
                            }
                        }
                    })
                    .disposed(by: self.rx.disposeBag)
                
                // bind filter button
                searchResult
                    .filterButtonView
                    .movieButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.searchViewModel.filter(search: .movie)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                
                searchResult
                    .filterButtonView
                    .tvShowButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.searchViewModel.filter(search: .tv)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                searchResult
                    .filterButtonView
                    .peopleButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.searchViewModel.filter(search: .person)
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
        
        // bind search controller
        searchController
            .searchBar
            .rx
            .textDidBeginEditing
            .asDriver()
            .drive(onNext: {
                self.filterBarButton.isEnabled = false
            })
            .disposed(by: rx.disposeBag)
        
        searchController
            .searchBar
            .rx
            .cancelButtonClicked
            .asDriver()
            .drive(onNext: {
                self.filterBarButton.isEnabled = true
            })
            .disposed(by: rx.disposeBag)
        
        searchController
            .rx
            .didDismiss
            .subscribe { _ in
                self.filterBarButton.isEnabled = true
            }
            .disposed(by: rx.disposeBag)
        
        searchController
            .searchBar
            .rx
            .searchButtonClicked
            .asDriver()
            .drive(onNext: {
                guard
                    let text = self.searchController.searchBar.text,
                    text.isNotEmpty
                else {
                    return
                }
                self.search(text: text)
            })
            .disposed(by: rx.disposeBag)
        
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

        searchViewModel
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
                    self.searchResult?.showEmptyLabel(message: NSLocalizedString("Error getting search result", comment: ""))
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
        self.searchViewModel.search(text: text)
    }
}
