//
//  KeywordViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/10/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift
import NotificationBannerSwift

protocol KeywordViewModelProtocol: ApplyProtocol {
    var keywords: BehaviorSubject<[Keyword]> { get }
    var repository: TMDBSearchRepository { get }
    var isLoading: BehaviorSubject<Bool> { get }
    var hideErrorLabel: PublishSubject<Bool> { get }
    var errorLabel: PublishSubject<NSAttributedString> { get }

    func handleKeyword(at: Int, isSelected: Bool)
    func isThere(keyword: Keyword, at: Int) -> Bool
    func searchKeyword(query: String, nextPage: Bool)
    func resetSearch()
}

class KeywordViewModel: KeywordViewModelProtocol {
    var repository: TMDBSearchRepository
    
    var query: DiscoverQuery?
    
    var page: Int = 1
    
    var totalPages: Int = 0

    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    var hideErrorLabel: PublishSubject<Bool> = PublishSubject()
    
    var errorLabel: PublishSubject<NSAttributedString> = PublishSubject()
    
    var initialKeywords: [Keyword] = [
        Keyword(name: "action hero", id: 219404), Keyword(name: "alternate history", id: 12026),
        Keyword(name: "ambiguous ending", id: 256055), Keyword(name: "americana", id: 165508),
        Keyword(name: "anime", id: 210024), Keyword(name: "anti hero", id: 2095),
        Keyword(name: "avant-garde", id: 15216), Keyword(name: "b movie", id: 11034),
        Keyword(name: "bank heist", id: 191845), Keyword(name: "based on novel", id: 274858)
    ]
    
    var keywords: BehaviorSubject<[Keyword]>
    
    init(repository: TMDBSearchRepository) {
        keywords = BehaviorSubject(value: initialKeywords)
        self.repository = repository
    }
    
    func handleKeyword(at: Int, isSelected: Bool) {
        let currentKeywords = try! keywords.value()

        if isSelected {
            query?.keywords.append(currentKeywords[at])
        } else {
            query?.keywords.removeAll(where: { $0 == currentKeywords[at] })
        }
    }
    
    func searchKeyword(query: String, nextPage: Bool) {
        let isLoading = try! self.isLoading.value()

        if nextPage && (page >= totalPages || isLoading) {
            return
        }
        
        if !nextPage {
            keywords.onNext([])
        }
        
        self.hideErrorLabel.onNext(true)
        self.isLoading.onNext(true)
        
        repository.searchKeyword(query: query, page: nextPage ? page + 1 : page) { result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let keyword):
                var keywordResult = try! self.keywords.value()
                keywordResult.append(contentsOf: keyword.results)

                if keywordResult.isEmpty {
                    self.hideErrorLabel.onNext(false)
                    self.errorLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("No keywords found", comment: "")))
                }

                self.page = keyword.page
                self.totalPages = keyword.totalPages
                self.keywords.onNext(keywordResult)

            case .failure(let error):
                debugPrint("Error searching for keyword: \(error.localizedDescription)")
                if !nextPage {
                    self.errorLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("Error getting keyword", comment: "")))
                    self.hideErrorLabel.onNext(false)
                }
                StatusBarNotificationBanner(title: "Fail getting search keyword", style: .danger).show(queuePosition: .back,
                                                                                                       bannerPosition: .bottom,
                                                                                                       queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func isThere(keyword: Keyword, at: Int) -> Bool {
        return query?.keywords.contains(where: { $0 == keyword }) ?? false
    }
    
    func apply(query: DiscoverQuery?) {
        var previousKeywords = try! keywords.value()

        self.query = query
        
        for keyword in query?.keywords ?? [] where !previousKeywords.contains(where: { $0 == keyword })  {
            previousKeywords.append(keyword)
        }

        keywords.onNext(previousKeywords)
    }
    
    func resetSearch() {
        let filterSelectedKeywords = query?.keywords.filter {
            $0.name != "action hero" || $0.name != "alternate history" || $0.name != "ambiguous ending" || $0.name != "americana" ||
            $0.name != "anime" || $0.name != "anti hero" || $0.name != "avant-garde" || $0.name != "b movie" ||
            $0.name != "bank heist" || $0.name != "based on novel"
        }
        initialKeywords.append(contentsOf: filterSelectedKeywords ?? [])
        keywords.onNext(initialKeywords)
    }
}
