//
//  TVShowDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift
import NotificationBannerSwift

protocol TVShowDetailViewModelProtocol {
    var repository: TMDBTVShowRepository { get }
    var backdropImages: PublishSubject<[Images]> { get }
    var tvShowDetail: PublishSubject<TVShow> { get }
    var numberOfEpisode: PublishSubject<NSAttributedString> { get }
    var numberOfSeason: PublishSubject<NSAttributedString> { get }
    var inProduction: PublishSubject<NSAttributedString> { get }
    var firstAirDate: PublishSubject<NSAttributedString> { get }
    var lastAirDate: PublishSubject<NSAttributedString> { get }
    var originalLanguage: PublishSubject<NSAttributedString> { get }
    var status: PublishSubject<NSAttributedString> { get }
    var countries: PublishSubject<NSAttributedString> { get }
    var languages: PublishSubject<NSAttributedString> { get }
    var title: PublishSubject<NSAttributedString> { get }
    var episodeRuntime: PublishSubject<NSAttributedString> { get }
    var homepage: PublishSubject<NSAttributedString> { get }
    var overview: PublishSubject<NSAttributedString> { get }
    var keywords: PublishSubject<[Keyword]> { get }
    var genres: PublishSubject<[Genre]> { get }
    var reviewAndEpisode: PublishSubject<[String]> { get }
    var credits: BehaviorSubject<[TVShowDetailModel]> { get }
    
    var isThereCast: Bool { get }
    var isThereCrew: Bool { get }
    var isThereSimilarTVShow: Bool { get }
    var isThereRecommendTVShow: Bool { get }
    
    var userSetting: TMDBUserSettingProtocol { get }
     
    func getTVShowDetail(tvShowId: Int)
    func getImages(tvShowId: Int)
    func getCasts(tvShowId: Int)
    func getCrews(tvShowId: Int)
    func getSimilars(tvShowId: Int)
    func getRecommends(tvShowId: Int)
    func getTVShowSeasons(tvShowId: Int) -> [Season]
    func getTVShowReview(tvShowId: Int) -> [Review]
    
    func resetCreditHeaderState()
    func resetMovieHeaderState()
}

class TVShowDetailViewModel: TVShowDetailViewModelProtocol {
    var repository: TMDBTVShowRepository
    var backdropImages: PublishSubject<[Images]> = PublishSubject()
    var tvShowDetail: PublishSubject<TVShow> = PublishSubject()
    var numberOfEpisode: PublishSubject<NSAttributedString> = PublishSubject()
    var numberOfSeason: PublishSubject<NSAttributedString> = PublishSubject()
    var inProduction: PublishSubject<NSAttributedString> = PublishSubject()
    var firstAirDate: PublishSubject<NSAttributedString> = PublishSubject()
    var lastAirDate: PublishSubject<NSAttributedString> = PublishSubject()
    var originalLanguage: PublishSubject<NSAttributedString> = PublishSubject()
    var status: PublishSubject<NSAttributedString> = PublishSubject()
    var countries: PublishSubject<NSAttributedString> = PublishSubject()
    var languages: PublishSubject<NSAttributedString> = PublishSubject()
    var title: PublishSubject<NSAttributedString> = PublishSubject()
    var homepage: PublishSubject<NSAttributedString> = PublishSubject()
    var episodeRuntime: PublishSubject<NSAttributedString> = PublishSubject()
    var overview: PublishSubject<NSAttributedString> = PublishSubject()
    var keywords: PublishSubject<[Keyword]> = PublishSubject()
    var genres: PublishSubject<[Genre]> = PublishSubject()
    var reviewAndEpisode: PublishSubject<[String]> = PublishSubject()
    var credits: BehaviorSubject<[TVShowDetailModel]> = BehaviorSubject(value: [
        .Credits(items: []),
        .TVShowsLikeThis(items: [])
    ])
    
    var isThereCast: Bool = true
    var isThereCrew: Bool = true
    var isThereSimilarTVShow: Bool = true
    var isThereRecommendTVShow: Bool = true
    
    lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { result in
        switch result {
        case .success(let result):
            guard let credits = try? self.credits.value().first else {
                self.credits.onNext([.TVShowsLikeThis(items: result.onTV.map{ CustomElementType(identity: $0) })])
                return
            }
            
            switch credits {
            case .Credits(items: _):
                self.credits.onNext([
                    credits,
                    .TVShowsLikeThis(items: result.onTV.map{ CustomElementType(identity: $0) })
                ])
            case .TVShowsLikeThis(items: _):
                self.credits.onNext([.TVShowsLikeThis(items: result.onTV.map{ CustomElementType(identity: $0) })])
            }
        case .failure(let error):
            debugPrint("Error getting similar tvshow: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: "Fail getting similar tvshow", style: .danger).show(queuePosition: .back,
                                                                                                   bannerPosition: .top,
                                                                                                   queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
        }
    }

    var userSetting: TMDBUserSettingProtocol

    init(repository: TMDBTVShowRepository, userSetting: TMDBUserSettingProtocol) {
        self.repository = repository
        self.userSetting = userSetting
    }
    
    func getTVShowDetail(tvShowId: Int) {
        repository.getTVShowDetail(from: tvShowId) { result in
            switch result {
            case .success(let result):
                self.tvShowDetail.onNext(result)
                self.keywords.onNext(Array(result.keywords?.results ?? List<Keyword>()))
                self.genres.onNext(Array(result.genres))
                self.reviewAndEpisode.onNext([NSLocalizedString("Review", comment: "") + " (\(result.reviews?.reviews.count ?? 0))",
                                              NSLocalizedString("Season", comment: "") + " (\(result.numberOfSeasons))" ])
                if result.homepage.isNotEmpty {
                    self.homepage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""), subTitle: result.homepage))
                }
                
                if result.overview.isNotEmpty {
                    self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                        paragraph: result.overview))
                }
                
                self.numberOfEpisode.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Number Of Episode", comment: ""),
                                                                      subTitle: String(result.numberOfEpisodes)))
                self.numberOfSeason.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Number Of Seasadson", comment: ""),
                                                                      subTitle: String(result.numberOfSeasons)))
                self.inProduction.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("In Production", comment: ""),
                                                                    subTitle: result.inProduction ? NSLocalizedString("Yes", comment: "") : NSLocalizedString("No", comment: "")))
                self.firstAirDate.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("First Air Date", comment: ""),
                                                                    subTitle: result.firstAirDate))
                self.lastAirDate.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Last Air Date", comment: ""),
                                                                   subTitle: result.lastAirDate))
                self.originalLanguage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Original Language", comment: ""),
                                                                        subTitle: self.userSetting.languagesCode.first(where: { $0.iso6391 == result.originalLanguage })?.name))
                self.status.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Status", comment: ""),
                                                              subTitle: result.status))
                self.countries.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Countries", comment: ""),
                                                                 subTitle: Array(result.originCountry).joined(separator: ", ")))
                self.languages.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Language", comment: ""),
                                                                 subTitle: Array(result.languages).map { language in
                                                                    return self.userSetting.languagesCode.first(where: { $0.iso6391 == language })?.name ?? ""
                                                                }.joined(separator: ", ")))
                self.title.onNext(TMDBLabel.setHeader(title: result.originalName))
                
                self.episodeRuntime.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Episode Runtime", comment: ""),
                                                                      subTitle: Array(result.episodeRunTime).map { String($0) }.joined(separator: ", ") + " min"))
                
                var credits = Array(result.credits?.cast ?? List<Cast>()).map { CustomElementType(identity: $0) }
                
                if credits.isEmpty {
                    credits = Array(result.credits?.crew ?? List<Crew>()).map { CustomElementType(identity: $0) }
                }
                
                if result.credits?.cast.isEmpty ?? true {
                    self.isThereCast = false
                }
                
                if result.credits?.crew.isEmpty ?? true {
                    self.isThereCrew = false
                }

                var tvshowLikeThis = Array(result.similar?.onTV ?? List<TVShow>()).map { CustomElementType(identity: $0) }

                if tvshowLikeThis.isEmpty {
                    self.isThereSimilarTVShow = false
                    tvshowLikeThis = Array(result.recommendations?.onTV ?? List<TVShow>()).map { CustomElementType(identity: $0) }
                }
                
                if tvshowLikeThis.isEmpty || result.recommendations?.onTV.isEmpty ?? true {
                    self.isThereRecommendTVShow = false
                }
                
                if credits.isEmpty && tvshowLikeThis.isEmpty {
                    self.credits.onNext([])
                } else if credits.isEmpty {
                    self.credits.onNext([.TVShowsLikeThis(items: tvshowLikeThis)])
                } else if tvshowLikeThis.isEmpty {
                    self.credits.onNext([.Credits(items: credits)])
                } else {
                    self.credits.onNext([
                        .Credits(items: credits),
                        .TVShowsLikeThis(items: tvshowLikeThis)
                    ])
                }
            case .failure(let error):
                debugPrint("Error getting tvshow detail \(tvShowId): \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting popular people", style: .danger).show(queuePosition: .back,
                                                                                                       bannerPosition: .top,
                                                                                                       queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func getImages(tvShowId: Int) {
        repository.getTVShowImages(from: tvShowId) { result in
            switch result {
            case .success(let result):
                self.backdropImages.onNext(Array(result.backdrops))
            case .failure(let error):
                debugPrint("Error getting tvshow detail: \(error.localizedDescription)")
            }
        }
    }
    
    func getCasts(tvShowId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let casts = self.repository.getTVShowCast(from: tvShowId).map { CustomElementType(identity: $0) }
            
            guard let tvShowLikeThis = try? self.credits.value().dropFirst() else {
                self.credits.onNext([.Credits(items: casts)])
                return
            }
            
            self.credits.onNext([
                .Credits(items: casts)
            ] + tvShowLikeThis)
        }
    }

    func getCrews(tvShowId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let crews = self.repository.getTVShowCrew(from: tvShowId).map { CustomElementType(identity: $0) }
            
            guard let tvShowLikeThis = try? self.credits.value().dropFirst() else {
                self.credits.onNext([.Credits(items: crews)])
                return
            }
            
            self.credits.onNext([
                .Credits(items: crews)
            ] + tvShowLikeThis)
        }
    }

    func getSimilars(tvShowId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.repository.getSimilarTVShows(from: tvShowId, page: 1, completion: self.tvShowHandler)
        }
    }

    func getRecommends(tvShowId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.repository.getRecommendTVShows(from: tvShowId, page: 1, completion: self.tvShowHandler)
        }
    }
    
    func getTVShowSeasons(tvShowId: Int) -> [Season] {
        return repository.getTVShowSeasons(from: tvShowId)
    }
    
    func getTVShowReview(tvShowId: Int) -> [Review] {
        return repository.getTVShowReviews(from: tvShowId)
    }
    
    func resetCreditHeaderState() {
        isThereCrew = true
        isThereCast = true
    }

    func resetMovieHeaderState() {
        isThereRecommendTVShow = true
        isThereSimilarTVShow = true
    }
}
