//
//  EpisodeViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/1/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift
import RxDataSources
import RealmSwift

protocol EpisodeViewModelProtocol {
    var images: PublishSubject<[Images]> { get }
    var credits: BehaviorSubject<[SectionModel<String, Object>]> { get }
    
    var userSetting: TMDBUserSettingProtocol { get }
    var repository: TMDBTVShowRepository { get }
    
    func getImages(tvShowId: Int, seasonNumber: Int, episodeNumber: Int)
    func getCast(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Cast]
    func getCrew(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Crew]
}

class EpisodeViewModel: EpisodeViewModelProtocol {
    var images: PublishSubject<[Images]> = PublishSubject()
    var credits: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    
    var userSetting: TMDBUserSettingProtocol
    
    var repository: TMDBTVShowRepository
    
    init(repository: TMDBTVShowRepository, userSetting: TMDBUserSettingProtocol) {
        self.repository = repository
        self.userSetting = userSetting
    }
    
    func getImages(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        repository.getTVShowEpisodeImage(from: tvShowId,
                                         seasonNumber: seasonNumber,
                                         episodeNumber: episodeNumber) { result in
            
            switch result {
            case .success(let imageResult):
                self.images.onNext(Array(imageResult.backdrops) + Array(imageResult.posters) + Array(imageResult.stills))
            case .failure(let error):
                debugPrint("Error getting episode images: \(error.localizedDescription)")
                self.images.onNext([])
            }
        }
    }
    
    func getCast(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Cast] {
        repository.getTVShowEpisodeCast(from: tvShowId,
                                        seasonNumber: seasonNumber,
                                        episodeNumber: episodeNumber)
    }
    
    func getCrew(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> [Crew] {
        repository.getTVShowEpisodeCrew(from: tvShowId,
                                        seasonNumber: seasonNumber,
                                        episodeNumber: episodeNumber)
    }
}
