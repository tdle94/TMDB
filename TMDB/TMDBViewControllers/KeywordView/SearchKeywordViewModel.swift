//
//  SearchKeywordViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/11/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift
import NotificationBannerSwift

protocol SearchKeywordViewModelProtocol {
    var keywords: BehaviorSubject<[Keyword]?> { get }
    var selectedKeywords: [Keyword] { get }
    var repository: TMDBSearchRepository { get }

    func searchKeyword(query: String, nextPage: Bool)
    func handleKeyword(at: Int, isSelected: Bool)
}

class SearchKeywordViewModel: SearchKeywordViewModelProtocol {
    var keywords: BehaviorSubject<[Keyword]?> = BehaviorSubject(value: [
        Keyword(name: "slasher", id: 12339), Keyword(name: "zombie", id: 12377),
        Keyword(name: "serial killer", id: 10714), Keyword(name: "high school", id: 6270),
        Keyword(name: "psychopath", id: 6259), Keyword(name: "chick flick", id: 33455),
        Keyword(name: "monster", id: 1299), Keyword(name: "murder", id: 9826),
        Keyword(name: "blockbuster", id: 268433), Keyword(name: "hero", id: 1701)
    ])

    var selectedKeywords: [Keyword] = []

    var repository: TMDBSearchRepository
    
    init(repository: TMDBSearchRepository) {
        self.repository = repository
    }
    
    func searchKeyword(query: String, nextPage: Bool) {
        selectedKeywords.removeAll()
        repository.searchKeyword(query: query, page: 1) { result in
            switch result {
            case .success(let keyword):
                self.keywords.onNext(keyword.results)
            case .failure(let error):
                debugPrint("Error searching for keyword: \(error.localizedDescription)")
                self.keywords.onNext(nil)
                StatusBarNotificationBanner(title: "Fail getting search keyword", style: .danger).show(queuePosition: .back,
                                                                                                       bannerPosition: .top,
                                                                                                       queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func handleKeyword(at: Int, isSelected: Bool) {
        guard let currentKeywords = try! keywords.value() else {
            return
        }

        if isSelected {
            selectedKeywords.append(currentKeywords[at])
        } else {
            selectedKeywords.removeAll(where: { $0 == currentKeywords[at] } )
        }
    }
}
