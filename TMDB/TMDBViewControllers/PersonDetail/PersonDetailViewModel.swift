//
//  PersonDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift
import NotificationBannerSwift

protocol PersonDetailViewModelProtocol {
    var profileCollectionImages: PublishSubject<[Images]> { get }
    var personName: PublishSubject<NSAttributedString> { get }
    var personDetail: PublishSubject<People> { get }
    var personBirthDay: PublishSubject<NSAttributedString> { get }
    var personDeathDay: PublishSubject<NSAttributedString> { get }
    var gender: PublishSubject<NSAttributedString> { get }
    var occupation: PublishSubject<NSAttributedString> { get }
    var imdb: PublishSubject<NSAttributedString> { get }
    var homepage: PublishSubject<NSAttributedString> { get }
    var alias: PublishSubject<NSAttributedString> { get }
    var biography: PublishSubject<NSAttributedString> { get }
    var credits: BehaviorSubject<[PersonDetailModel]> { get }
    
    var isThereMovie: Bool { get }
    var isThereTVShow: Bool { get }
     
    var userSetting: TMDBUserSettingProtocol { get }
    var repository: TMDBPeopleRepository { get }
    
    func getPersonDetail(id: Int)
    func getMoviesAppearIn(personId: Int)
    func getTVShowsAppearIn(personId: Int)
    func resetCreditHeaderState()
}

class PersonDetailViewModel: PersonDetailViewModelProtocol {
    var profileCollectionImages: PublishSubject<[Images]> = PublishSubject()
    var personName: PublishSubject<NSAttributedString> = PublishSubject()
    var personDetail: PublishSubject<People> = PublishSubject()
    var personBirthDay: PublishSubject<NSAttributedString> = PublishSubject()
    var personDeathDay: PublishSubject<NSAttributedString> = PublishSubject()
    var gender: PublishSubject<NSAttributedString> = PublishSubject()
    var occupation: PublishSubject<NSAttributedString> = PublishSubject()
    var imdb: PublishSubject<NSAttributedString> = PublishSubject()
    var homepage: PublishSubject<NSAttributedString> = PublishSubject()
    var alias: PublishSubject<NSAttributedString> = PublishSubject()
    var biography: PublishSubject<NSAttributedString> = PublishSubject()
    var credits: BehaviorSubject<[PersonDetailModel]> = BehaviorSubject(value: [])
    
    var isThereMovie: Bool = true
    var isThereTVShow: Bool = true

    var userSetting: TMDBUserSettingProtocol
    var repository: TMDBPeopleRepository
    
    init(repository: TMDBPeopleRepository, userSetting: TMDBUserSettingProtocol) {
        self.repository = repository
        self.userSetting = userSetting
    }
    
    func getPersonDetail(id: Int) {
        repository.getPersonDetail(id: id) { result in
            switch result {
            case .success(let personResult):
                self.personDetail.onNext(personResult)
                
                if !personResult.biography.isEmpty {
                    self.personName.onNext(TMDBLabel.setAtributeParagraph(title: personResult.name,
                                                                          paragraph: personResult.biography))
                } else {
                    self.personName.onNext(TMDBLabel.setHeader(title: personResult.name))
                }
                
                
                var placeOfBirth = personResult.placeOfBirth?.isEmpty ?? true ? "" : personResult.placeOfBirth!
                
                if !placeOfBirth.isEmpty {
                    placeOfBirth = " in \(placeOfBirth)"
                }
        
                if let birthday = personResult.birthday, !birthday.isEmpty {
                    self.personBirthDay.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Birthday", comment: ""),
                                                                          subTitle: birthday + placeOfBirth))
                }
                
                if let deathday = personResult.deathday, !deathday.isEmpty {
                    self.personDeathDay.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Deathday", comment: ""),
                                                                          subTitle: personResult.deathday))
                }
                
                if let homepage = personResult.homepage, !homepage.isEmpty {
                    self.homepage.onNext(TMDBLabel.setAttributeText(title: "Homepage", subTitle: homepage))
                }
                
                if !personResult.alsoKnownAs.isEmpty {
                    self.alias.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Aliases", comment: ""),
                                                                 subTitle: personResult.alsoKnownAs.joined(separator: ", ")))
                }
                
                if let imdbId = personResult.imdbId, !imdbId.isEmpty {
                    self.imdb.onNext(TMDBLabel.setAttributeText(title: "IMDB", subTitle: imdbId))
                }

                if personResult.movieCredits?.cast.isEmpty ?? true, personResult.tvCredits?.cast.isEmpty ?? true {
                    self.isThereMovie = false
                    self.isThereTVShow = false
                    self.credits.onNext([])
                } else if personResult.movieCredits?.cast.isEmpty ?? true {
                    self.isThereMovie = false
                    self.credits.onNext([
                        .Credits(items: personResult.tvCredits!.cast.map { CustomElementType(identity: $0) } ),
                    ])
                } else if personResult.tvCredits?.cast.isEmpty ?? true {
                    self.isThereTVShow = false
                    self.credits.onNext([
                        .Credits(items: personResult.movieCredits!.cast.map { CustomElementType(identity: $0) } ),
                    ])
                } else {
                    self.credits.onNext([
                        .Credits(items: personResult.movieCredits!.cast.map { CustomElementType(identity: $0) } ),
                    ])
                }
                

                self.gender.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Gender", comment: ""),
                                                              subTitle: personResult.gender == 2 ? NSLocalizedString("Male", comment: "") : NSLocalizedString("Female", comment: "")))
                
                self.occupation.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Occupation", comment: ""),
                                                                  subTitle: personResult.knownForDepartment))
                
                self.profileCollectionImages.onNext(Array(personResult.images?.profiles ?? List<Images>()))
            case .failure(let error):
                debugPrint("Error getting season detail \(id): \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting person detail", style: .danger).show(queuePosition: .back,
                                                                                                      bannerPosition: .top,
                                                                                                      queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func getMoviesAppearIn(personId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let movies = self.repository.getMovieCredits(from: personId)
            self.credits.onNext([.Credits(items: movies.map { CustomElementType(identity: $0) })])
        }
        
    }

    func getTVShowsAppearIn(personId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let tvshows = self.repository.getTVCredits(from: personId)
            self.credits.onNext([.Credits(items: tvshows.map { CustomElementType(identity: $0) })])
        }
    }
    
    func resetCreditHeaderState() {
        self.isThereMovie = true
        self.isThereTVShow = true
    }
}
