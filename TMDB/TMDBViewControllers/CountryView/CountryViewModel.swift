//
//  CountryViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/12/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift

protocol CountryViewModelProtocol {
    var userSetting: TMDBUserSettingProtocol { get }
    var countries: BehaviorSubject<[CountryCode]> { get }
    var query: DiscoverQuery? { get set }
    var selectedRow: Int? { get }
    
    func handleSelect(at: Int, isSelected: Bool)
    func search(country query: String)
    func resetSearch()
}

class CountryViewModel: CountryViewModelProtocol {
    var userSetting: TMDBUserSettingProtocol
    
    var countries: BehaviorSubject<[CountryCode]> = BehaviorSubject(value: [])
    
    var query: DiscoverQuery?
    
    var selectedRow: Int? {
        return userSetting.countriesCode.firstIndex(where: { $0.iso31661 == query?.region })
    }
    
    init(userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
        countries.onNext(userSetting.countriesCode)
    }
    
    func handleSelect(at: Int, isSelected: Bool) {
        let previousCountries = try! countries.value()
    
        if isSelected {
            query?.region = previousCountries[at].iso31661
        } else {
            query?.region = nil
        }
    }
    
    func search(country query: String) {
        let newCountries = userSetting.countriesCode.filter { $0.name.contains(query) }
        
        self.query?.region = nil
        
        countries.onNext(newCountries)
    }
    
    func resetSearch() {
        countries.onNext(userSetting.countriesCode)
    }
}
