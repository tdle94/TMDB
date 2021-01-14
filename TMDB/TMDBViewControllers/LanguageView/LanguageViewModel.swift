//
//  LanguageViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/14/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift

protocol LanguageViewModelProtocol {
    var languages: BehaviorSubject<[LanguageCode]> { get }
    var query: DiscoverQuery? { get set }
    var selectedRow: Int? { get }
    var userSetting: TMDBUserSettingProtocol { get }
    
    func handleSelect(at: Int, isSelected: Bool)
    func search(language query: String)
    func resetSearch()
}

class LanguageViewModel: LanguageViewModelProtocol {
    var userSetting: TMDBUserSettingProtocol
    
    var query: DiscoverQuery?
    
    var selectedRow: Int? {
        let currentLanguages = try! languages.value()
        return currentLanguages.firstIndex(where: { $0.iso6391 == query?.withOriginalLanguage })
    }
    
    var languages: BehaviorSubject<[LanguageCode]> = BehaviorSubject(value: [])
    
    init(userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
        languages.onNext(userSetting.languagesCode)
    }
    
    func handleSelect(at: Int, isSelected: Bool) {
        let currentLanguages = try! languages.value()

        if isSelected {
            query?.withOriginalLanguage = currentLanguages[at].iso6391
        } else {
            query?.withOriginalLanguage = nil
        }
    }

    func search(language query: String) {
        let filterLanguages = userSetting.languagesCode.filter { $0.name.contains(query) }

        languages.onNext(filterLanguages)
    }

    func resetSearch() {
        languages.onNext(userSetting.languagesCode)
    }
}
