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
    var searchResult: BehaviorSubject<[MultiSearch]> { get }
    var oldSearchText: String { get }
    
    func search(text: String)
    func resetSearch()
}

class SearchViewViewModel: SearchViewViewModelProtocol {
    var repository: TMDBSearchRepository
    var page: Int = 0
    var totalPages: Int = 0
    var oldSearchText: String = ""
    var searchResult: BehaviorSubject<[MultiSearch]> = BehaviorSubject(value: [])

    init(repository: TMDBSearchRepository) {
        self.repository = repository
    }
    
    func resetSearch() {
        oldSearchText = ""
        totalPages = 0
        page = 0
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
                    do {

                        let previousSearchResults = try self.searchResult.value()
                        let newSearchResults = previousSearchResults + searchResult.results
                        
                        self.searchResult.onNext(newSearchResults)

                    } catch let error {
                        debugPrint("Error getting new page for same search result: \(error.localizedDescription)")
                        self.searchResult.onError(error)
                    }
                    
                } else {
                    self.searchResult.onNext(searchResult.results)
                }
                
                self.page = newPage
                self.totalPages = searchResult.totalPages
                self.oldSearchText = text
            case .failure(let error):
                debugPrint("Error getting search result: \(error.localizedDescription)")
                self.searchResult.onError(error)
            }
            
        }
    }
}
