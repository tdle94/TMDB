//
//  TVShowDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift

protocol TVShowDetailViewModelProtocol {
    var repository: TMDBTVShowRepository { get }
    var images: PublishSubject<[Images]> { get }
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
    
    var userSetting: TMDBUserSettingProtocol { get }
     
    func getTVShowDetail(tvShowId: Int)
    func getImages(tvShowId: Int)
}

class TVShowDetailViewModel: TVShowDetailViewModelProtocol {
    var repository: TMDBTVShowRepository
    var images: PublishSubject<[Images]> = PublishSubject()
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

                if !result.homepage.isEmpty {
                    self.homepage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""), subTitle: result.homepage))
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
                self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                    paragraph: result.overview))
            case .failure(let error):
                self.tvShowDetail.onError(error)
            }
        }
    }
    
    func getImages(tvShowId: Int) {
        repository.getTVShowImages(from: tvShowId) { result in
            switch result {
            case .success(let result):
                self.images.onNext(Array(result.backdrops))
            case .failure(let error):
                self.images.onError(error)
            }
        }
    }
}
