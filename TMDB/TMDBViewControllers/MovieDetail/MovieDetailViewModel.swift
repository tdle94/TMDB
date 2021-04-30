//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 11/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift
import Foundation
import NotificationBannerSwift
import RxDataSources

protocol MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository { get }

    var userSetting: TMDBUserSettingProtocol { get }
    
    // movie
    var movieDetail: PublishSubject<Movie> { get }
    
    // backdrop images
    var images: PublishSubject<[Images]> { get }
    
    // label
    var status: PublishSubject<NSAttributedString> { get }
    var tagline: PublishSubject<NSAttributedString> { get }
    var produceInCountries: PublishSubject<NSAttributedString> { get }
    var imdb: PublishSubject<NSAttributedString> { get }
    var belongToCollection: PublishSubject<NSAttributedString> { get }
    var homepage: PublishSubject<NSAttributedString> { get }
    var overview: PublishSubject<NSAttributedString> { get }
    var title: PublishSubject<NSAttributedString> { get }
    var runtimeAndReleaseDate: PublishSubject<NSAttributedString> { get }
    var originalLanguage: PublishSubject<NSAttributedString> { get }
    var budget: PublishSubject<NSAttributedString> { get }
    var revenue: PublishSubject<NSAttributedString> { get }
    var availableLanguage: PublishSubject<NSAttributedString> { get }
    
    // table view
    var reviewAndRelease: PublishSubject<[String]> { get }
    
    // collection view
    var keywords: PublishSubject<[Keyword]> { get }
    var genres: PublishSubject<[Genre]> { get }
    var productionCompanies: PublishSubject<[ProductionCompany]> { get }
    var productionCompanyCollectionViewHeight: CGFloat { get }
    
    // poster url path
    var posterURL: PublishSubject<URL?> { get }
    
    // movie credit
    var credits: BehaviorSubject<[SectionModel<String, Object>]> { get }
    var noCast: Bool { get }
    var noCrew: Bool { get }
    var creditCollectionViewHeight: CGFloat { get }
    
    // similar and recommend movies
    var moviesLikeThis: BehaviorSubject<[SectionModel<String, Object>]> { get }
    var noSimilarMovie: Bool { get }
    var noRecommendMovie: Bool { get }
    var movieCollectionViewHeight: CGFloat { get }
    
    func getMovieDetail(movieId: Int)
    func getImages(movieId: Int)
    func getCasts(movieId: Int)
    func getCrews(movieId: Int)
    func getSimilarMovies(movieId: Int)
    func getRecommendMovies(movieId: Int)
    func getReviews(movieId: Int) -> [Review]
    func getMovieKeywords(movieId: Int) -> [Keyword]
    func getMovieGenres(movieId: Int) -> [Genre]
    
    func handleMovieLikeThisSelection(at segment: Int, movieId: Int)
    func handleCreditSelection(at segment: Int, movieId: Int)
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository
    
    var userSetting: TMDBUserSettingProtocol
    
    // movie
    var movieDetail: PublishSubject<Movie> = PublishSubject()
    
    // backdrop images
    var images: PublishSubject<[Images]> = PublishSubject()
    
    // label
    var status: PublishSubject<NSAttributedString> = PublishSubject()
    var tagline: PublishSubject<NSAttributedString> = PublishSubject()
    var produceInCountries: PublishSubject<NSAttributedString> = PublishSubject()
    var imdb: PublishSubject<NSAttributedString> = PublishSubject()
    var belongToCollection: PublishSubject<NSAttributedString> = PublishSubject()
    var homepage: PublishSubject<NSAttributedString> = PublishSubject()
    var overview: PublishSubject<NSAttributedString> = PublishSubject()
    var title: PublishSubject<NSAttributedString> = PublishSubject()
    var runtimeAndReleaseDate: PublishSubject<NSAttributedString> = PublishSubject()
    var originalLanguage: PublishSubject<NSAttributedString> = PublishSubject()
    var budget: PublishSubject<NSAttributedString> = PublishSubject()
    var revenue: PublishSubject<NSAttributedString> = PublishSubject()
    var availableLanguage: PublishSubject<NSAttributedString> = PublishSubject()
    
    // table view
    var reviewAndRelease: PublishSubject<[String]> = PublishSubject()
    
    // collection view
    var keywords: PublishSubject<[Keyword]> = PublishSubject()
    var genres: PublishSubject<[Genre]> = PublishSubject()
    var productionCompanies: PublishSubject<[ProductionCompany]> = PublishSubject()
    var productionCompanyCollectionViewHeight: CGFloat = 0

    // poster url path
    var posterURL: PublishSubject<URL?> = PublishSubject()
    
    // movie credit
    var credits: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    var noCast: Bool = true
    var noCrew: Bool = true
    var creditCollectionViewHeight: CGFloat {
        return noCast && noCrew ? 0 : Constant.collectionViewHeight
    }
    
    // similar and recommend movies
    var moviesLikeThis: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    var noSimilarMovie: Bool = true
    var noRecommendMovie: Bool = true
    var movieCollectionViewHeight: CGFloat {
        return noSimilarMovie && noRecommendMovie ? 0 : Constant.collectionViewHeight
    }
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { [unowned self] result in
        switch result {
        case .success(let movieResult):
            self.moviesLikeThis.onNext([SectionModel(model: "movie", items: Array(movieResult.movies))])
        case .failure(let error):
            debugPrint("Error getting similar movies: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: "Fail getting movie", style: .danger).show(queuePosition: .back,
                                                                                                   bannerPosition: .top,
                                                                                                   queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
        }
    }
    
    init(movieRepository: TMDBMovieRepository, userSetting: TMDBUserSettingProtocol) {
        repository = movieRepository
        self.userSetting = userSetting
    }
    
    func getMovieDetail(movieId: Int) {
        repository.getMovieDetail(id: movieId) { result in
            switch result {
            case .success(let movieDetailResult):
                self.productionCompanyCollectionViewHeight = movieDetailResult.productionCompanies.isEmpty ? 0 : Constant.productionCompanyCollectionViewHeight
                
                self.movieDetail.onNext(movieDetailResult)
                
                self.status.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Status", comment: ""),
                                                              subTitle: movieDetailResult.status))
                self.tagline.onNext(TMDBLabel.setAttributeText(title: movieDetailResult.tagline ?? ""))

                self.imdb.onNext(TMDBLabel.setAttributeText(title: "IMDB",
                                                            subTitle: movieDetailResult.imdbId ?? ""))

                self.produceInCountries.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Produced In", comment: ""),
                                                                            subTitle: Array(movieDetailResult.productionCountries).map { $0.name }.joined(separator: ", ") ))

                self.belongToCollection.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Collection", comment: ""),
                                                                            subTitle: movieDetailResult.belongToCollection?.name ))

                self.homepage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""),
                                                                subTitle: movieDetailResult.homepage ?? ""))

                self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                    paragraph: movieDetailResult.overview ?? ""))
                
                self.posterURL.onNext(self.userSetting.getImageURL(from: movieDetailResult.posterPath))

                var movies = Array(movieDetailResult.similar?.movies ?? List<Movie>())
                
                if movies.isEmpty {
                    movies = Array(movieDetailResult.recommendations?.movies ?? List<Movie>())
                }
                
                self.moviesLikeThis.onNext([SectionModel(model: "movies", items: movies)])
                
                self.noSimilarMovie = movieDetailResult.similar?.movies.isEmpty ?? true
                self.noRecommendMovie = movieDetailResult.recommendations?.movies.isEmpty ?? true
                
                var movieCredit: [Object] = Array(movieDetailResult.credits?.cast ?? List<Cast>())
                
                self.noCast = movieDetailResult.credits?.cast.isEmpty ?? true
                self.noCrew = movieDetailResult.credits?.crew.isEmpty ?? true
                
                if movieCredit.isEmpty {
                    movieCredit = Array(movieDetailResult.credits?.crew ?? List<Crew>())
                }
                
                self.credits.onNext([SectionModel(model: "credits", items: movieCredit)])
                
                self.keywords.onNext(Array(movieDetailResult.keywords?.keywords ?? List<Keyword>()))
                self.genres.onNext(Array(movieDetailResult.genres))
                self.productionCompanies.onNext(Array(movieDetailResult.productionCompanies))
                
                self.reviewAndRelease.onNext([
                    NSLocalizedString("Review", comment: "") + " (\(movieDetailResult.reviews?.totalResults ?? 0))",
                    NSLocalizedString("Release Date", comment: "") + " (\(movieDetailResult.releaseDates?.results.count ?? 0))"
                ])
                
                self.title.onNext(TMDBLabel.setHeader(title: movieDetailResult.title))
                
                var releaseDate = ""
                var producedInCountriesAbbreviation = Array(movieDetailResult.productionCountries).map { $0.ios31661 }.joined(separator: ", ")
                
                if !producedInCountriesAbbreviation.isEmpty {
                    producedInCountriesAbbreviation = "(\(producedInCountriesAbbreviation))"
                }

                
                if let date = movieDetailResult.releaseDate, !date.isEmpty {
                    releaseDate = "\u{2022} \(date)"
                }
                
                self.runtimeAndReleaseDate.onNext(TMDBLabel.setHeader(title: "\(movieDetailResult.runtime / 60)h \(movieDetailResult.runtime % 60)mins \(releaseDate) \(producedInCountriesAbbreviation)"))

                self.originalLanguage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Original Language", comment: ""),
                                                                        subTitle: self.userSetting.languagesCode.first(where: { $0.iso6391 == movieDetailResult.originalLanguage })?.name))
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                self.budget.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Budget", comment: ""),
                                                              subTitle: "$\(numberFormatter.string(from: NSNumber(value: movieDetailResult.budget)) ?? "0.0")"))
                self.revenue.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Revenue", comment: ""),
                                                               subTitle: "$\(numberFormatter.string(from: NSNumber(value: movieDetailResult.revenue)) ?? "0.0")"))
                

                self.availableLanguage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Available Lanuages", comment: ""),
                                                                        subTitle: Array(movieDetailResult.spokenLanguages).map { $0.name }.joined(separator: ", ")))

            case .failure(let error):
                debugPrint("Error getting movie detail \(movieId): \(error.localizedDescription)")
                StatusBarNotificationBanner(title: "Fail getting movie detail people", style: .danger).show(queuePosition: .back,
                                                                                                       bannerPosition: .top,
                                                                                                       queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func getImages(movieId: Int) {
        repository.getMovieImages(from: movieId) { result in
            switch result {
            case .success(let imageResult):
                if imageResult.backdrops.isEmpty, imageResult.stills.isEmpty, imageResult.posters.isEmpty {
                    self.images.onNext([Images()]) // image holder
                } else {
                    self.images.onNext(Array(imageResult.backdrops) + Array(imageResult.stills) + Array(imageResult.posters))
                }
            case .failure(let error):
                debugPrint("Error getting movie images \(movieId): \(error.localizedDescription)")
            }
        }
    }
    
    func getCasts(movieId: Int) {
        let casts = repository.getMovieCast(from: movieId)
        credits.onNext([SectionModel(model: "credit", items: casts)])
    }
    
    func getCrews(movieId: Int) {
        let crews = repository.getMovieCrew(from: movieId)
        credits.onNext([SectionModel(model: "credit", items: crews)])
    }
    
    func getSimilarMovies(movieId: Int) {
        self.repository.getSimilarMovies(from: movieId, page: 1, completion: self.movieHandler)
    }
    
    func getRecommendMovies(movieId: Int) {
        self.repository.getRecommendMovies(from: movieId, page: 1, completion: self.movieHandler)
    }
    
    func getReviews(movieId: Int) -> [Review] {
        self.repository.getMovieReview(from: movieId)
    }
    
    func getMovieKeywords(movieId: Int) -> [Keyword] {
        self.repository.getMovieKeywords(from: movieId)
    }
    
    func getMovieGenres(movieId: Int) -> [Genre] {
        self.repository.getMovieGenre(from: movieId)
    }
    
    func handleMovieLikeThisSelection(at segment: Int, movieId: Int) {
        if segment == 0 {
            getSimilarMovies(movieId: movieId)
        } else {
            getRecommendMovies(movieId: movieId)
        }
    }
    
    func handleCreditSelection(at segment: Int, movieId: Int) {
        if segment == 0 {
            getCasts(movieId: movieId)
        } else {
            getCrews(movieId: movieId)
        }
    }
}
