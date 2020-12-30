//
//  SearchViewViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/25/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import RxSwift

protocol SearchViewViewModelProtocol {
    var repository: TMDBSearchRepository { get }
    var page: Int { get }
    var totalPages: Int { get }
    var searchResult: BehaviorSubject<[MultiSearch]?> { get }
    var oldSearchText: String { get }
    
    func search(text: String)
    func filter(search type: SearchViewViewModel.SearchType)
}

class SearchViewViewModel: SearchViewViewModelProtocol {
    
    enum SearchType: String {
        case movie = "movie"
        case tv = "tv"
        case person = "person"
        case none
    }
    
    var searchType: SearchType = .none
    
    var repository: TMDBSearchRepository
    var page: Int = 0
    var totalPages: Int = 0
    var oldSearchText: String = ""
    var searchResult: BehaviorSubject<[MultiSearch]?> = BehaviorSubject(value: [])
    var oldSearchResult: [MultiSearch] = []

    init(repository: TMDBSearchRepository) {
        self.repository = repository
    }
    
    func search(text: String) {
        let newPage: Int
        
        if text == oldSearchText {
            newPage = self.page + 1
        } else {
            newPage = 1
        }
        
        if newPage > totalPages, totalPages != 0 {
            do {
                let previousSearchResults = try self.searchResult.value()
                self.searchResult.onNext(previousSearchResults)
            } catch let error {
                debugPrint("Error getting previous search result when there is no new page: \(error.localizedDescription)")
                self.searchResult.onError(error)
            }
            return
        }

        repository.multiSearch(query: text, page: newPage) { result in
            switch result {
            case .success(let searchResult):
                if text == self.oldSearchText {

                    var newSearchResults = self.oldSearchResult + searchResult.results

                    self.oldSearchResult = newSearchResults

                    if self.searchType != .none {
                        newSearchResults = newSearchResults.filter { $0.mediaType == self.searchType.rawValue }
                    }

                    self.searchResult.onNext(newSearchResults)
                    
                } else {
                    self.oldSearchResult = searchResult.results
                    if self.searchType == .none {
                        self.searchResult.onNext(searchResult.results)
                    } else {
                        self.searchResult.onNext(searchResult.results.filter { $0.mediaType == self.searchType.rawValue })
                    }
                }
                
                self.page = newPage
                self.totalPages = searchResult.totalPages
                self.oldSearchText = text
            case .failure(let error):
                debugPrint("Error getting search result: \(error.localizedDescription)")
                self.searchResult.onNext(nil)
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
