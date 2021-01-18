//
//  ReleaseDateViewViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/31/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift

protocol ReleaseDateViewModelProtocol {
    var repository: TMDBMovieRepository { get }
    var releaseDates: BehaviorSubject<[ReleaseDateResult]> { get }
    
    func getReleaseDates(movieId: Int)
    func filter(query country: String)
    func resetFilter()
    func getCountryNameFrom(iso31661: String) -> String
}

class ReleaseDateViewModel: ReleaseDateViewModelProtocol {
    var releaseDates: BehaviorSubject<[ReleaseDateResult]> = BehaviorSubject(value: [])
    var saveReleaseDates: [ReleaseDateResult] = []

    var repository: TMDBMovieRepository
    
    var userSetting: TMDBUserSettingProtocol
    
    init(repository: TMDBMovieRepository, userSetting: TMDBUserSettingProtocol) {
        self.repository = repository
        self.userSetting = userSetting
    }
    
    func getReleaseDates(movieId: Int) {
        if let releaseDate = repository.getMovieReleaseDates(from: movieId) {
            saveReleaseDates = Array(releaseDate.results)
            releaseDates.onNext(saveReleaseDates)
        } else {
            saveReleaseDates = []
            releaseDates.onNext([])
        }
    }

    func filter(query country: String) {
            
        let searchCountryCode = userSetting.countriesCode.filter { $0.name.lowercased().contains(country.lowercased()) }
        var searchCountriesReleaseDatesResult: [ReleaseDateResult] = []
            
        for releaseDate in saveReleaseDates where searchCountryCode.contains(where: { $0.iso31661 == releaseDate.iso31661 }) {
            searchCountriesReleaseDatesResult.append(releaseDate)
        }
            
        self.releaseDates.onNext(searchCountriesReleaseDatesResult)
    }
    
    func resetFilter() {
        self.releaseDates.onNext(saveReleaseDates)
    }
    
    func getCountryNameFrom(iso31661: String) -> String {
        return userSetting.countriesCode.first(where: { $0.iso31661 == iso31661 })?.name ?? ""
    }
}
