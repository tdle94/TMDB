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
    var searchResult: BehaviorSubject<[MultiSearch]?> { get }
    var oldSearchText: String { get }
    
    func search(text: String)
    func filter(search type: SearchViewViewModel.SearchType)
}

class SearchViewViewModel: SearchViewModelProtocol {
    
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
    var searchResult: BehaviorSubject<[MultiSearch]?> = BehaviorSubject(value: [])
    var oldSearchResult: [MultiSearch] = []

    init(searchRepository: TMDBSearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(text: String) {
        let newPage: Int
        
        if text == oldSearchText {
            newPage = self.page + 1
        } else {
            newPage = 1
        }
        
        if newPage > totalPages, totalPages != 0 {
            self.searchResult.onNext(nil)
            return
        }

        searchRepository.multiSearch(query: text, page: newPage) { result in
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
                
                
                self.page = newPage
                self.totalPages = searchResult.totalPages
                self.oldSearchText = text
            case .failure(let error):
                debugPrint("Error getting search result: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting search", style: .danger).show(queuePosition: .back,
                                                                                               bannerPosition: .top,
                                                                                               queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                let previousSearchResults = try! self.searchResult.value()
                if !(previousSearchResults?.isEmpty ?? true) {
                    self.searchResult.onNext(previousSearchResults)
                } else {
                    self.searchResult.onNext(nil)
                }
            }
            
        }
    }
    
    func filter(search type: SearchViewViewModel.SearchType) {
        if searchType == type {
            searchType = .none
            searchResult.onNext(oldSearchResult)
            return
        }
        searchType = type
        searchResult.onNext(oldSearchResult.filter { $0.mediaType == type.rawValue })
    }
}
