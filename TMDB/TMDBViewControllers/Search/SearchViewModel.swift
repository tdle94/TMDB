//
//  SearchViewViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/25/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import RxSwift
import NotificationBannerSwift

protocol SearchViewModelProtocol {
    var searchRepository: TMDBSearchRepository { get }
    var page: Int { get }
    var totalPages: Int { get }
    var searchResult: BehaviorSubject<[MultiSearch]> { get }
    var oldSearchText: String { get }
    var isLoading: BehaviorSubject<Bool> { get }
    var notificationLabel: PublishSubject<String> { get }
    var hideNotificationLabel: PublishSubject<Bool> { get }
    
    func search(text: String)
    func filter(search type: SearchViewModel.SearchType)
    func getSearchResult(at: Int) -> MultiSearch?
}

class SearchViewModel: SearchViewModelProtocol {
    
    enum SearchType: String {
        case movie = "movie"
        case tv = "tv"
        case person = "person"
        case none
    }
    
    var searchType: SearchType = .none
    
    var searchRepository: TMDBSearchRepository
    var page: Int = 0
    var totalPages: Int = 0
    var oldSearchText: String = ""
    var searchResult: BehaviorSubject<[MultiSearch]> = BehaviorSubject(value: [])
    var oldSearchResult: [MultiSearch] = []
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var notificationLabel: PublishSubject<String> = PublishSubject()
    var hideNotificationLabel: PublishSubject<Bool> = PublishSubject()

    init(searchRepository: TMDBSearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(text: String) {
        if try! isLoading.value() {
            return
        }

        let newPage: Int
        
        if text == oldSearchText {
            newPage = self.page + 1
        } else {
            searchResult.onNext([])
            newPage = 1
        }

        isLoading.onNext(true)
        hideNotificationLabel.onNext(true)

        if newPage > totalPages, totalPages != 0 {
            isLoading.onNext(false)
            return
        }

        searchRepository.multiSearch(query: text, page: newPage) { result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let searchResult):
                if text == self.oldSearchText {
                    self.oldSearchResult = self.oldSearchResult + searchResult.results
                } else {
                    self.oldSearchResult = searchResult.results
                }
                
                if self.searchType != .none {
                    self.searchResult.onNext(self.oldSearchResult.filter { $0.mediaType == self.searchType.rawValue })
                } else {
                    self.searchResult.onNext(self.oldSearchResult)
                }
                
                if self.oldSearchResult.isEmpty {
                    self.hideNotificationLabel.onNext(false)
                    self.notificationLabel.onNext(NSLocalizedString("No item found", comment: ""))
                }
                
                self.page = newPage
                self.totalPages = searchResult.totalPages
                self.oldSearchText = text
            case .failure(let error):
                if try! self.searchResult.value().isEmpty {
                    self.hideNotificationLabel.onNext(false)
                    self.notificationLabel.onNext(NSLocalizedString("Error getting search result", comment: ""))
                }
                debugPrint("Error getting search result: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting search", style: .danger).show(queuePosition: .back,
                                                                                               bannerPosition: .top,
                                                                                               queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
            
        }
    }
    
    func filter(search type: SearchViewModel.SearchType) {
        if searchType == type {
            searchType = .none
            searchResult.onNext(oldSearchResult)
            return
        }
        searchType = type

        let filterResult = oldSearchResult.filter { $0.mediaType == type.rawValue }

        if filterResult.isEmpty {
            self.notificationLabel.onNext(NSLocalizedString("No item found", comment: ""))
        }
        searchResult.onNext(filterResult)
    }
    
    func getSearchResult(at: Int) -> MultiSearch? {
        return try! searchResult.value()[at]
    }
}
