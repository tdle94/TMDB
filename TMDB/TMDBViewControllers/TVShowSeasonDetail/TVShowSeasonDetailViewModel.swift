//
//  TVShowSeasonDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift
import NotificationBannerSwift

protocol TVShowSeasonDetailViewModelProtocol {
    var userSetting: TMDBUserSettingProtocol { get }
    var backdropImages: PublishSubject<[Images]> { get }
    var season: PublishSubject<Season> { get }
    var airDate: PublishSubject<NSAttributedString> { get }
    var title: PublishSubject<NSAttributedString> { get }
    var numberOfEpisode: PublishSubject<NSAttributedString> { get }
    var overview: PublishSubject<NSAttributedString> { get }
    var credit: BehaviorSubject<[TVShowSeasonDetailModel]> { get }
    
    var isThereCrew: Bool { get }
    var isThereCast: Bool { get }
    
    var repository: TMDBTVShowRepository { get }
    
    func getSeasonDetail(tvShowId: Int, seasonNumber: Int)
    func getSeasonCasts(tvShowId: Int, seasonNumber: Int)
    func getSeasonCrews(tvShowId: Int, seasonNumber: Int)
    
    func resetCreditHeaderState()
}

class TVShowSeasonDetailViewModel: TVShowSeasonDetailViewModelProtocol {
    
    var userSetting: TMDBUserSettingProtocol
    
    var repository: TMDBTVShowRepository
    
    var isThereCrew: Bool = true
    var isThereCast: Bool = true
    
    var backdropImages: PublishSubject<[Images]> = PublishSubject()
    var airDate: PublishSubject<NSAttributedString> = PublishSubject()
    var title: PublishSubject<NSAttributedString> = PublishSubject()
    var numberOfEpisode: PublishSubject<NSAttributedString> = PublishSubject()
    var overview: PublishSubject<NSAttributedString> = PublishSubject()
    var season: PublishSubject<Season> = PublishSubject()
    var credit: BehaviorSubject<[TVShowSeasonDetailModel]> = BehaviorSubject(value: [.Credits(items: [])])
    
    init(repository: TMDBTVShowRepository, userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
        self.repository = repository
    }
    
    func getSeasonDetail(tvShowId: Int, seasonNumber: Int) {
        repository.getTVShowSeasonDetail(from: tvShowId, seasonNumber: seasonNumber) { result in
            switch result {
            case .success(let season):
                self.season.onNext(season)
                
                if let airDate = season.airDate, !airDate.isEmpty {
                    self.airDate.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Air On", comment: ""),
                                                                   subTitle: airDate))
                }
                
                if !season.overview.isEmpty {
                    self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                        paragraph: season.overview))
                }
                
                self.numberOfEpisode.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Number Of Episode", comment: ""),
                                                                       subTitle: String(season.episodeCount)))
                
                self.title.onNext(TMDBLabel.setHeader(title: season.name))

                if season.credits?.cast.isEmpty ?? true, season.credits?.crew.isEmpty ?? true {
                    self.credit.onNext([])
                    self.isThereCrew = false
                    self.isThereCast = false
                } else if season.credits?.cast.isEmpty ?? true {
                    self.isThereCast = false
                    self.credit.onNext([.Credits(items: Array(season.credits!.crew.map { CustomElementType(identity: $0) }) )])
                } else if season.credits?.crew.isEmpty ?? true {
                    self.isThereCrew = false
                    self.credit.onNext([.Credits(items: Array(season.credits!.cast.map { CustomElementType(identity: $0) }) )])
                } else {
                    self.credit.onNext([.Credits(items: Array(season.credits!.cast.map { CustomElementType(identity: $0) }) )])
                }

            case .failure(let error):
                debugPrint("Error getting season detail \(tvShowId): \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting tv show season detail", style: .danger).show(queuePosition: .back,
                                                                                                              bannerPosition: .top,
                                                                                                              queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
        
        repository.getTVShowSeasonImage(from: tvShowId, seasonNumber: seasonNumber) { result in
            switch result {
            case .success(let imageResult):
                self.backdropImages.onNext(Array(imageResult.backdrops) + Array(imageResult.posters) + Array(imageResult.stills))
            case .failure(let error):
                debugPrint("Error getting season images: \(error.localizedDescription)")
            }
        }
    }

    func getSeasonCasts(tvShowId: Int, seasonNumber: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let casts = self.repository.getTVShowSeasonCasts(from: tvShowId, seasonNumber: seasonNumber)
            self.credit.onNext([.Credits(items: casts.map { CustomElementType(identity: $0) } )])
        }
    }

    func getSeasonCrews(tvShowId: Int, seasonNumber: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let crews = self.repository.getTVShowSeasonCrews(from: tvShowId, seasonNumber: seasonNumber)
            self.credit.onNext([.Credits(items: crews.map { CustomElementType(identity: $0) } )])
        }
    }
    
    func resetCreditHeaderState() {
        isThereCast = true
        isThereCrew = true
    }
}
