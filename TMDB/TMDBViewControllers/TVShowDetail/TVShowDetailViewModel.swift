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
import RxDataSources

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
    var credits: BehaviorSubject<[SectionModel<String, Object>]> { get}
    var tvshows: BehaviorSubject<[SectionModel<String, Object>]> { get}
    
    // poster url path
    var posterURL: PublishSubject<URL?> { get }
    
    var userSetting: TMDBUserSettingProtocol { get }
    
    var noSimilarTVShow: Bool { get }
    var noRecommendTVShow: Bool { get }
    var noCast: Bool { get }
    var noCrew: Bool { get }
    
    var creditCollectionViewHeight: CGFloat { get }
    var tvshowCollectionViewHeight: CGFloat { get }
     
    func getTVShowDetail(tvShowId: Int)
    func getImages(tvShowId: Int)
    func getCasts(tvShowId: Int)
    func getCrews(tvShowId: Int)
    func getSimilars(tvShowId: Int)
    func getRecommends(tvShowId: Int)
    func getTVShowSeasons(tvShowId: Int) -> [Season]
    func getTVShowReview(tvShowId: Int) -> [Review]
    
    func handleCreditSelection(at: Int, tvshowId: Int)
    func handleTVShowLikeThisSelection(at: Int, tvshowId: Int)
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
    var credits: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    var tvshows: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    
    // poster url path
    var posterURL: PublishSubject<URL?> = PublishSubject()

    var userSetting: TMDBUserSettingProtocol
    
    var noSimilarTVShow: Bool = true
    var noRecommendTVShow: Bool = true
    var noCast: Bool = true
    var noCrew: Bool = true
    
    var creditCollectionViewHeight: CGFloat {
        return noCrew && noCast ? 0 : Constant.collectionViewHeight
    }
    
    var tvshowCollectionViewHeight: CGFloat {
        return noSimilarTVShow && noRecommendTVShow ? 0 : Constant.collectionViewHeight
    }
     
    
    lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { [unowned self] result in
        switch result {
        case .success(let result):
            self.tvshows.onNext([SectionModel(model: "tvshow", items: Array(result.onTV))])
        case .failure(let error):
            debugPrint("Error getting similar tvshow: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: "Fail getting similar tvshow", style: .danger).show(queuePosition: .back,
                                                                                                   bannerPosition: .top,
                                                                                                   queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
        }
    }

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
                self.homepage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""), subTitle: result.homepage))
                
                self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                    paragraph: result.overview))
                
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
                
                self.posterURL.onNext(self.userSetting.getImageURL(from: result.posterPath))
                
                self.noSimilarTVShow = result.similar?.onTV.isEmpty ?? true
                self.noRecommendTVShow = result.recommendations?.onTV.isEmpty ?? true
                
                self.noCast = result.credits?.cast.isEmpty ?? true
                self.noCrew = result.credits?.crew.isEmpty ?? true
                
                var tvshowLikeThis = Array(result.similar?.onTV ?? List<TVShow>())
                var tvshowCredit: [Object] = Array(result.credits?.cast ?? List<Cast>())
                
                if tvshowCredit.isEmpty {
                    tvshowCredit = Array(result.credits?.crew ?? List<Crew>())
                }

                if tvshowLikeThis.isEmpty {
                    tvshowLikeThis = Array(result.recommendations?.onTV ?? List<TVShow>())
                }
                
                self.credits.onNext([SectionModel(model: "credit", items: tvshowCredit)])
                self.tvshows.onNext([SectionModel(model: "tvshow", items: tvshowLikeThis)])
                
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
                if result.backdrops.isEmpty, result.stills.isEmpty, result.posters.isEmpty {
                    self.backdropImages.onNext([Images()])
                } else {
                    self.backdropImages.onNext(Array(result.backdrops) + Array(result.stills) + Array(result.posters))
                }
            case .failure(let error):
                debugPrint("Error getting tvshow detail: \(error.localizedDescription)")
            }
        }
    }
    
    func getCasts(tvShowId: Int) {
        let casts = self.repository.getTVShowCast(from: tvShowId)
        credits.onNext([SectionModel(model: "credit", items: casts)])
    }

    func getCrews(tvShowId: Int) {
        let crews = self.repository.getTVShowCrew(from: tvShowId)
        credits.onNext([SectionModel(model: "credit", items: crews)])
    }

    func getSimilars(tvShowId: Int) {
        self.repository.getSimilarTVShows(from: tvShowId, page: 1, completion: self.tvShowHandler)
    }

    func getRecommends(tvShowId: Int) {
        self.repository.getRecommendTVShows(from: tvShowId, page: 1, completion: self.tvShowHandler)
    }
    
    func getTVShowSeasons(tvShowId: Int) -> [Season] {
        return repository.getTVShowSeasons(from: tvShowId)
    }
    
    func getTVShowReview(tvShowId: Int) -> [Review] {
        return repository.getTVShowReviews(from: tvShowId)
    }
    
    func handleCreditSelection(at: Int, tvshowId: Int) {
        if at == 0 {
            getCasts(tvShowId: tvshowId)
        } else {
            getCrews(tvShowId: tvshowId)
        }
    }
    
    func handleTVShowLikeThisSelection(at: Int, tvshowId: Int) {
        if at == 0 {
            getSimilars(tvShowId: tvshowId)
        } else {
            getRecommends(tvShowId: tvshowId)
        }
    }
}
