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

protocol EpisodeDetailViewModelProtocol {
    var images: PublishSubject<[Images]> { get }
    var credits: BehaviorSubject<[EpisodeDetailModel]> { get }
    
    var userSetting: TMDBUserSettingProtocol { get }
    var repository: TMDBTVShowRepository { get }
    
    var isThereGuestStar: Bool { get }
    
    func getImages(tvShowId: Int, seasonNumber: Int, episodeNumber: Int)
    func getGuestStar(tvShowId: Int, seasonNumber: Int, episodeNumber: Int)
    
    func resetGuestStarHeaderState()
}

class EpisodeDetailViewModel: EpisodeDetailViewModelProtocol {
    var images: PublishSubject<[Images]> = PublishSubject()
    var credits: BehaviorSubject<[EpisodeDetailModel]> = BehaviorSubject(value: [])
    
    var isThereGuestStar: Bool = true
    
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
    
    func getGuestStar(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        let guestStar = repository.getTVShowEpisodeGuestStar(from: tvShowId,
                                                             seasonNumber: seasonNumber,
                                                             episodeNumber: episodeNumber)
        
        if guestStar.isEmpty {
            isThereGuestStar = false
        }

        credits.onNext([.Credits(items: guestStar.map { CustomElementType(identity: $0) })])
    }
    
    func resetGuestStarHeaderState() {
        isThereGuestStar = true
    }
}
