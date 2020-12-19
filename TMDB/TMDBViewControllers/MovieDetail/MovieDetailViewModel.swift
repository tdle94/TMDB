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

protocol MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository { get }
    var movie: PublishSubject<Movie> { get }
    var images: PublishSubject<[Images]> { get }
    var keywords: PublishSubject<[Keyword]> { get }
    var credits: BehaviorSubject<[MovieDetailModel]> { get }
    
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
    var productionCompanyCollectionViewHeight: PublishSubject<CGFloat> { get }
    var productionCompanyCollectionViewTop: PublishSubject<CGFloat> { get }
    var keywordCollectionViewTop: PublishSubject<CGFloat> { get }
    var keywordCollectionViewHeight: PublishSubject<CGFloat> { get }
    var runtimeAndReleaseDateTop: PublishSubject<CGFloat> { get }
    
    var isThereSimilarMovie: Bool { get }
    var isThereRecommendMovie: Bool { get }
    var isThereCast: Bool { get }
    var isThereCrew: Bool { get }
    
    var userSetting: TMDBUserSettingProtocol { get }
    
    func getMovieDetail(movieId: Int)
    func getImages(movieId: Int)
    func getCasts(movieId: Int)
    func getCrews(movieId: Int)
    func getSimilarMovies(movieId: Int)
    func getRecommendMovies(movieId: Int)
    func resetCreditHeaderState()
    func resetMovieHeaderState()
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository
    var movie: PublishSubject<Movie> = PublishSubject()
    var images: PublishSubject<[Images]> = PublishSubject()
    var keywords: PublishSubject<[Keyword]> = PublishSubject()
    var credits: BehaviorSubject<[MovieDetailModel]> = BehaviorSubject(value: [.Credits(items: []),
                                                                               .MoviesLikeThis(items: [])])
    
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
    
    var productionCompanyCollectionViewHeight: PublishSubject<CGFloat> = PublishSubject()
    var productionCompanyCollectionViewTop: PublishSubject<CGFloat> = PublishSubject()
    var keywordCollectionViewTop: PublishSubject<CGFloat> = PublishSubject()
    var keywordCollectionViewHeight: PublishSubject<CGFloat> = PublishSubject()
    var runtimeAndReleaseDateTop: PublishSubject<CGFloat> = PublishSubject()
    
    var isThereSimilarMovie: Bool = true
    var isThereRecommendMovie: Bool = true
    var isThereCast: Bool = true
    var isThereCrew: Bool = true
    
    var userSetting: TMDBUserSettingProtocol
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { result in
        switch result {
        case .success(let movieResult):
            guard let credit = try? self.credits.value().first else {
                self.credits.onNext([
                    .MoviesLikeThis(items: Array(movieResult.movies).map { CustomElementType(identity: $0) })
                ])
                return
            }

            switch credit {
            case .Credits(items: _):
                self.credits.onNext([
                    credit,
                    .MoviesLikeThis(items: Array(movieResult.movies).map { CustomElementType(identity: $0) })
                ])
            case .MoviesLikeThis(items: _):
                self.credits.onNext([
                    credit,
                    .MoviesLikeThis(items: Array(movieResult.movies).map { CustomElementType(identity: $0) })
                ])
            }
        case .failure(let error):
            self.credits.onError(error)
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
                self.movie.onNext(movieDetailResult)
                self.keywords.onNext(Array(movieDetailResult.keywords?.keywords ?? List<Keyword>()))

                // keyword
                if movieDetailResult.keywords?.keywords.isEmpty ?? true {
                    self.keywordCollectionViewTop.onNext(0)
                    self.keywordCollectionViewHeight.onNext(0)
                    self.runtimeAndReleaseDateTop.onNext(0)
                }
                
                // movie credit
                
                var moviesLikeThisOne = Array((movieDetailResult.similar?.movies ?? List<Movie>()).map { CustomElementType(identity: $0) })
                
                if moviesLikeThisOne.isEmpty {
                    self.isThereSimilarMovie = false
                    moviesLikeThisOne = Array((movieDetailResult.recommendations?.movies ?? List<Movie>()).map { CustomElementType(identity: $0) })
                }
                
                if moviesLikeThisOne.isEmpty || (movieDetailResult.recommendations?.movies.isEmpty ?? true) {
                    self.isThereRecommendMovie = false
                }
                
                

                var credits = Array(movieDetailResult.credits?.cast ?? List<Cast>()).map { CustomElementType(identity: $0) }
                
                if credits.isEmpty {
                    self.isThereCast = false
                    credits = Array(movieDetailResult.credits?.crew ?? List<Crew>()).map { CustomElementType(identity: $0) }
                }
                
                if credits.isEmpty || (movieDetailResult.credits?.crew.isEmpty ?? true) {
                    self.isThereCrew = false
                }
                
                if moviesLikeThisOne.isEmpty,
                   credits.isEmpty {
                    self.credits.onNext([])
                } else if moviesLikeThisOne.isEmpty {
                    self.credits.onNext([.Credits(items: credits)])
                } else if credits.isEmpty {
                    self.credits.onNext([.MoviesLikeThis(items: moviesLikeThisOne)])
                } else {
                    self.credits.onNext([
                        .Credits(items: credits),
                        .MoviesLikeThis(items: moviesLikeThisOne),
                    ])
                }
                
                // label
                self.status.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Status", comment: ""),
                                                              subTitle: movieDetailResult.status))
                self.tagline.onNext(TMDBLabel.setAttributeText(title: movieDetailResult.tagline ?? ""))
                
                if let imdbId = movieDetailResult.imdbId, !imdbId.isEmpty {
                    self.imdb.onNext(TMDBLabel.setAttributeText(title: "IMDB",
                                                                subTitle: imdbId))
                }
                
                if !movieDetailResult.productionCountries.isEmpty {
                    self.produceInCountries.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Produced In", comment: ""),
                                                                              subTitle: Array(movieDetailResult.productionCountries).map { $0.name }.joined(separator: ", ") ))
                }
                
                if let collection = movieDetailResult.belongToCollection?.name {
                    self.belongToCollection.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Collection", comment: ""),
                                                                              subTitle: collection))
                }
                
                if let homepage = movieDetailResult.homepage, !homepage.isEmpty {
                    self.homepage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""),
                                                                    subTitle: homepage))
                }
                
                self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                    paragraph: movieDetailResult.overview ?? ""))
                
                self.title.onNext(TMDBLabel.setHeader(title: movieDetailResult.title))
                
                var releaseDate = ""
                var producedInCountriesAbbreviation = Array(movieDetailResult.productionCountries).map { $0.ios31661 }.joined(separator: ", ")
                
                if !producedInCountriesAbbreviation.isEmpty {
                    producedInCountriesAbbreviation = "(\(producedInCountriesAbbreviation))"
                }
                
                if movieDetailResult.productionCompanies.filter({ $0.logoPath != nil }).isEmpty {
                    self.productionCompanyCollectionViewTop.onNext(0)
                    self.productionCompanyCollectionViewHeight.onNext(0)
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
                
                let availableLanguages = Array(movieDetailResult.spokenLanguages).map { $0.name }.joined(separator: ", ")
                if !availableLanguages.isEmpty {
                    self.availableLanguage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Available Lanuages", comment: ""),
                                                                             subTitle: availableLanguages))
                }
            case .failure(let error):
                self.movie.onError(error)
            }
        }
    }
    
    func getImages(movieId: Int) {
        repository.getMovieImages(from: movieId) { result in
            switch result {
            case .success(let imageResult):
                self.images.onNext(Array(imageResult.backdrops))
            case .failure(let error):
                self.images.onError(error)
            }
        }
    }
    
    func getCasts(movieId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let movieLikeThisModel = try? self.credits.value().dropFirst() else {
                self.credits.onNext([
                    .Credits(items: self.repository.getMovieCast(from: movieId).map { CustomElementType(identity: $0) })
                ])
                return
            }
            
            self.credits.onNext([
                .Credits(items: self.repository.getMovieCast(from: movieId).map { CustomElementType(identity: $0) }),
            ] + movieLikeThisModel)
        }
    }
    
    func getCrews(movieId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard let movieLikeThisModel = try? self.credits.value().dropFirst() else {
                self.credits.onNext([
                    .Credits(items: self.repository.getMovieCrew(from: movieId).map { CustomElementType(identity: $0) })
                ])
                return
            }

            self.credits.onNext([
                .Credits(items: self.repository.getMovieCrew(from: movieId).map { CustomElementType(identity: $0) }),
            ] +  movieLikeThisModel)
        }
    }
    
    func getSimilarMovies(movieId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.repository.getSimilarMovies(from: movieId, page: 1, completion: self.movieHandler)
        }
    }
    
    func getRecommendMovies(movieId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.repository.getRecommendMovies(from: movieId, page: 1, completion: self.movieHandler)
        }
    }
    
    func resetCreditHeaderState() {
        isThereCast = true
        isThereCrew = true
    }

    func resetMovieHeaderState() {
        isThereRecommendMovie = true
        isThereSimilarMovie = true
    }
}
