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
    
    weak var delegate: AppCoordinator?
    
    // MARK: - views
    var searchController: UISearchController
    
    var movieDiscoverCell: UICollectionViewCell?
    
    var tvDiscoverCell: UICollectionViewCell?
    
    private var searchResult: SearchResultView
    
    var filterBarButton = UIBarButtonItem(title: NSLocalizedString("Filter", comment: ""), style: .plain, target: nil, action: nil)

    @IBOutlet weak var discoveryChoiceView: DiscoveryFilterButtonView!
    @IBOutlet weak var discoveryCollectionView: UICollectionView! {
        didSet {
            discoveryCollectionView.collectionViewLayout = CollectionViewLayout.discoveryLayout()
            discoveryCollectionView.dataSource = self
            discoveryCollectionView.register(UINib(nibName: String(describing: DiscoverCollectionViewCell.self), bundle: nil),
                                             forCellWithReuseIdentifier: Constant.Identifier.cell)
        }
    }
    
    // MARK: - init
    init(searchController: UISearchController,
         searchViewModel: SearchViewModelProtocol,
         discoveryViewModel: DiscoveryViewModelProtocol) {
        self.searchViewModel = searchViewModel
        self.discoveryViewModel = discoveryViewModel
        self.searchController = searchController
        self.searchResult = (searchController.searchResultsController as? SearchResultView) ?? SearchResultView()
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
        navigationItem.setRightBarButton(filterBarButton, animated: true)
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
}

extension SearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let discoverCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.cell, for: indexPath) as! DiscoverCollectionViewCell

        if indexPath.row == 0, let cell = movieDiscoverCell {
            return cell
        } else if indexPath.row == 1, let cell = tvDiscoverCell {
            return cell
        }

        if indexPath.row == 0 {
            movieDiscoverCell = discoverCell
            
            // get first page initially
            discoveryViewModel.getAllMovie(nextPage: false)
            
            
            // bind inner collection view
            discoveryViewModel
                .movie
                .bind(to: discoverCell.entityCollectionView.rx.items(dataSource: discoverCell.movieDataSource))
                .disposed(by: self.rx.disposeBag)

            discoveryViewModel
                .hideMovieErrorLabel
                .bind(to: discoverCell.errorLabel.rx.isHidden)
                .disposed(by: self.rx.disposeBag)
            
            discoveryViewModel
                .movieNotificationLabel
                .bind(to: discoverCell.errorLabel.rx.attributedText)
                .disposed(by: rx.disposeBag)
            
            discoverCell
                .entityCollectionView
                .rx
                .willDisplaySupplementaryView
                .take(1)
                .subscribe(onNext: { view, _, _ in
                    let footer = view as! LoadingIndicatorView
                    
                    self.discoveryViewModel
                        .hideEndOfResultMovieLabel
                        .bind(to: footer.label.rx.isHidden)
                        .disposed(by: self.rx.disposeBag)
                    
                    self.discoveryViewModel
                        .isMovieLoading
                        .bind(to: footer.loadingIndicator.rx.isAnimating)
                        .disposed(by: self.rx.disposeBag)
                })
                .disposed(by: rx.disposeBag)
                
                
            discoverCell
                .entityCollectionView
                .rx
                .itemSelected
                .asDriver()
                .drive(onNext: { indexPath in
                    self.delegate?.navigateWith(obj: discoverCell.movieDataSource.sectionModels.first?.items[indexPath.row])
                })
                .disposed(by: self.rx.disposeBag)
            
            // paginate, when user scroll to bottom of collectionview
            discoverCell
                .entityCollectionView
                .rx
                .didScroll
                .filter { discoverCell.entityCollectionView.isAtBottom }
                .asDriver(onErrorDriveWith: .empty())
                .drive(onNext: {
                    self.discoveryViewModel.getAllMovie(nextPage: true)
                })
                .disposed(by: self.rx.disposeBag)
            
            return discoverCell
        }
        
        tvDiscoverCell = discoverCell
        
        // get first page initially
        discoveryViewModel.getAllTVShow(nextPage: false)
        
        // bind inner collection view
        discoveryViewModel
            .tvShow
            .bind(to: discoverCell.entityCollectionView.rx.items(dataSource: discoverCell.tvShowDataSource))
            .disposed(by: rx.disposeBag)
        
        discoveryViewModel
            .hideTVErrorLabel
            .bind(to: discoverCell.errorLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)

        discoveryViewModel
            .tvNotificationLabel
            .bind(to: discoverCell.errorLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        discoverCell
            .entityCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .subscribe(onNext: { view, _, _ in
                let footer = view as! LoadingIndicatorView
                
                self.discoveryViewModel
                    .hideEndOfReusultTVShowLabel
                    .bind(to: footer.label.rx.isHidden)
                    .disposed(by: self.rx.disposeBag)
                
                self.discoveryViewModel
                    .isTVLoading
                    .bind(to: footer.loadingIndicator.rx.isAnimating)
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: self.rx.disposeBag)
        
        discoverCell
            .entityCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.delegate?.navigateWith(obj: discoverCell.tvShowDataSource.sectionModels.first?.items[indexPath.row])
            })
            .disposed(by: rx.disposeBag)

        
        // paginate, when user scroll to bottom of collectionview
        discoverCell
            .entityCollectionView
            .rx
            .didScroll
            .filter { discoverCell.entityCollectionView.isAtBottom }
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                self.discoveryViewModel.getAllTVShow(nextPage: true)
            })
            .disposed(by: rx.disposeBag)
        
        return discoverCell
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
                self.delegate?.presentFilterView(applyFilter: self.discoveryViewModel)
            })
            .disposed(by: rx.disposeBag)
        
        Observable
            .merge(discoveryViewModel.movieFilterCountString, discoveryViewModel.tvshowFilterCountString)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { filterString in
                self.navigationItem.rightBarButtonItem = nil
                self.filterBarButton.title = filterString
                self.navigationItem.setRightBarButton(self.filterBarButton, animated: true)
            })
            .disposed(by: rx.disposeBag)

        discoveryCollectionView
            .rx
            .didEndDisplayingCell
            .asDriver()
            .drive(onNext: { event in
                self.discoveryChoiceView.select(at: event.at.row)
                self.discoveryViewModel.handleCollectionViewSwipe(at: event.at.row)
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
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { _ in
                
                // bind search result to tableview
                self.searchViewModel
                    .searchResult
                    .bind(to: self.searchResult.searchResultTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, item, cell in
                        (cell as? TMDBCustomTableViewCell)?.configure(item: item)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                // search new page when user scroll to bottom of tableview
                self.searchResult
                    .searchResultTableView
                    .rx
                    .didScroll
                    .filter { self.searchResult.searchResultTableView.isAtBottom }
                    .asDriver(onErrorDriveWith: .empty())
                    .drive(onNext: { _ in
                        self.searchViewModel.search(text: self.searchController.searchBar.text, nextPage: true)
                    })
                    .disposed(by: self.rx.disposeBag)
                
                // navigate when user tap on search result
                self.searchResult
                    .searchResultTableView
                    .rx
                    .itemSelected
                    .asDriver()
                    .drive(onNext: { indexPath in
                        self.delegate?.navigateWith(obj: self.searchViewModel.getSearchResult(at: indexPath.row))
                    })
                    .disposed(by: self.rx.disposeBag)
                
                // bind filter button
                self.searchResult
                    .filterButtonView
                    .movieButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.searchViewModel.filter(search: .movie)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                
                self.searchResult
                    .filterButtonView
                    .tvShowButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.searchViewModel.filter(search: .tv)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                self.searchResult
                    .filterButtonView
                    .peopleButton
                    .rx
                    .tap
                    .subscribe { _ in
                        self.searchViewModel.filter(search: .person)
                    }
                    .disposed(by: self.rx.disposeBag)
                
                self.searchResult
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
                
                self.searchViewModel
                    .isLoading
                    .bind(to: self.searchResult.footerLoadIndicatorView.rx.isAnimating)
                    .disposed(by: self.rx.disposeBag)
                
                self.searchViewModel
                    .notificationLabel
                    .bind(to: self.searchResult.emptyLabel.rx.attributedText)
                    .disposed(by: self.rx.disposeBag)
                
                self.searchViewModel
                    .hideNotificationLabel
                    .bind(to: self.searchResult.emptyLabel.rx.isHidden)
                    .disposed(by: self.rx.disposeBag)
                
                self.searchViewModel
                    .isLoading
                    .bind(to: self.searchResult.filterButtonView.rx.isHidden)
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
        
        Observable
            .of(searchController.searchBar.rx.cancelButtonClicked.asDriver(), searchController.rx.didDismiss.asDriver(onErrorJustReturn: ()))
            .merge()
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                self.filterBarButton.isEnabled = true
            })
            .disposed(by: rx.disposeBag)
        
        searchController
            .searchBar
            .rx
            .searchButtonClicked
            .asDriver()
            .drive(onNext: {
                self.searchViewModel.search(text: self.searchController.searchBar.text, nextPage: false)
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
                self.searchViewModel.search(text: query.identity, nextPage: false)
            })
            .disposed(by: rx.disposeBag)
    }
}
