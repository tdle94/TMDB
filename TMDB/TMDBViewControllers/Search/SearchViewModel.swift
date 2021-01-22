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
    var notificationLabel: PublishSubject<NSAttributedString> { get }
    var hideNotificationLabel: PublishSubject<Bool> { get }
    
    func search(text: String, nextPage: Bool)
    func filter(search type: MediaType)
    func getSearchResult(at: Int) -> MultiSearch?
}

extension SearchViewModelProtocol {
    func search(text: String, nextPage: Bool = false) {
        search(text: text, nextPage: nextPage)
    }
}

class SearchViewModel: SearchViewModelProtocol {
    
    var searchType: MediaType = .all
    
    var searchRepository: TMDBSearchRepository
    var page: Int = 0
    var totalPages: Int = 0
    var oldSearchText: String = ""
    var searchResult: BehaviorSubject<[MultiSearch]> = BehaviorSubject(value: [])
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var notificationLabel: PublishSubject<NSAttributedString> = PublishSubject()
    var hideNotificationLabel: PublishSubject<Bool> = PublishSubject()

    init(searchRepository: TMDBSearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(text: String, nextPage: Bool) {
        if try! isLoading.value() {
            return
        }

        let newPage: Int
        
        if nextPage {
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
                var oldSearchResult = try! self.searchResult.value()

                if nextPage {
                    oldSearchResult = oldSearchResult + searchResult.results
                } else {
                    oldSearchResult = searchResult.results
                }
                
                if self.searchType != .all {
                    oldSearchResult = oldSearchResult.filter { $0.mediaType == self.searchType.rawValue }
                }

                if oldSearchResult.isEmpty {
                    self.hideNotificationLabel.onNext(false)
                    self.notificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("No item found", comment: "")))
                }

                self.searchResult.onNext(oldSearchResult)

                self.page = newPage
                self.totalPages = searchResult.totalPages
                self.oldSearchText = text
            case .failure(let error):
                if try! self.searchResult.value().isEmpty {
                    self.hideNotificationLabel.onNext(false)
                    self.notificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("Error getting search result", comment: "")))
                }
                debugPrint("Error getting search result: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting search", style: .danger).show(queuePosition: .back,
                                                                                               bannerPosition: .top,
                                                                                               queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
            
        }
    }
    
    func filter(search type: MediaType) {
        searchType = type == searchType ? .all : type
        self.search(text: oldSearchText, nextPage: false)
    }
    
    func getSearchResult(at: Int) -> MultiSearch? {
        return try! searchResult.value()[at]
    }
}
