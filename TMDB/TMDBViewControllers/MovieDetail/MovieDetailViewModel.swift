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
    
    var movieParser: MovieParser { get }

    var userSetting: TMDBUserSettingProtocol { get }
    
    func getMovieDetail(movieId: Int)
    func getImages(movieId: Int)
    func getCasts(movieId: Int)
    func getCrews(movieId: Int)
    func getSimilarMovies(movieId: Int)
    func getRecommendMovies(movieId: Int)
    func getReviews(movieId: Int) -> [Review]
    
    func handleMovieLikeThisSelection(at segment: Int, movieId: Int)
    func handleCreditSelection(at segment: Int, movieId: Int)
}

class MovieParser {
    // MARK: - properties
    
    // movie
    var movie: PublishSubject<Movie> = PublishSubject()
    
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
    var productionCompaniesCollectionViewHeight: PublishSubject<CGFloat> = PublishSubject()
    
    // poster url path
    var posterURL: PublishSubject<URL> = PublishSubject()
    
    // movie credit
    var credits: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    
    // similar and recommend movies
    var moviesLikeThis: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])

    
    // MARK: - parse
    
    func parseLabel(movie: Movie, userSetting: TMDBUserSettingProtocol) {
        self.status.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Status", comment: ""),
                                                      subTitle: movie.status))
        self.tagline.onNext(TMDBLabel.setAttributeText(title: movie.tagline ?? ""))
        
        if let imdbId = movie.imdbId, !imdbId.isEmpty {
            self.imdb.onNext(TMDBLabel.setAttributeText(title: "IMDB",
                                                        subTitle: imdbId))
        }
        
        if !movie.productionCountries.isEmpty {
            self.produceInCountries.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Produced In", comment: ""),
                                                                      subTitle: Array(movie.productionCountries).map { $0.name }.joined(separator: ", ") ))
        }
        
        if let collection = movie.belongToCollection?.name {
            self.belongToCollection.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Collection", comment: ""),
                                                                      subTitle: collection))
        }
        
        if let homepage = movie.homepage, !homepage.isEmpty {
            self.homepage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Homepage", comment: ""),
                                                            subTitle: homepage))
        }
        
        if let overview = movie.overview, !overview.isEmpty {
            self.overview.onNext(TMDBLabel.setAtributeParagraph(title: NSLocalizedString("Overview", comment: ""),
                                                                paragraph: overview))
        }
        
        self.title.onNext(TMDBLabel.setHeader(title: movie.title))
        
        var releaseDate = ""
        var producedInCountriesAbbreviation = Array(movie.productionCountries).map { $0.ios31661 }.joined(separator: ", ")
        
        if !producedInCountriesAbbreviation.isEmpty {
            producedInCountriesAbbreviation = "(\(producedInCountriesAbbreviation))"
        }

        
        if let date = movie.releaseDate, !date.isEmpty {
            releaseDate = "\u{2022} \(date)"
        }
        
        self.runtimeAndReleaseDate.onNext(TMDBLabel.setHeader(title: "\(movie.runtime / 60)h \(movie.runtime % 60)mins \(releaseDate) \(producedInCountriesAbbreviation)"))

        self.originalLanguage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Original Language", comment: ""),
                                                                subTitle: userSetting.languagesCode.first(where: { $0.iso6391 == movie.originalLanguage })?.name))
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        self.budget.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Budget", comment: ""),
                                                      subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.budget)) ?? "0.0")"))
        self.revenue.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Revenue", comment: ""),
                                                       subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.revenue)) ?? "0.0")"))
        
        let availableLanguages = Array(movie.spokenLanguages).map { $0.name }.joined(separator: ", ")
        if !availableLanguages.isEmpty {
            self.availableLanguage.onNext(TMDBLabel.setAttributeText(title: NSLocalizedString("Available Lanuages", comment: ""),
                                                                     subTitle: availableLanguages))
        }
    }
    
    func parsePosterURL(movie: Movie, userSetting: TMDBUserSettingProtocol) {
        if let path = movie.posterPath, let url = userSetting.getImageURL(from: path) {
            posterURL.onNext(url)
        }
    }
    
    func parseMovie(_ movie: Movie) {
        self.movie.onNext(movie)

        parseKeyword(Array(movie.keywords?.keywords ?? List<Keyword>()))
        parseGenres(Array(movie.genres))
        parseProductionCompanies(Array(movie.productionCompanies))
        parseReviewAndRelease(movie: movie)
        parseMovieCredits(movie)
    }
    
    func parseMovieCredits(_ movie: Movie) {
        let similarMovies = Array(movie.similar?.movies ?? List<Movie>())
        let casts = Array(movie.credits?.cast ?? List<Cast>())

        moviesLikeThis.onNext([SectionModel(model: "movie", items: similarMovies)])
        credits.onNext([SectionModel(model: "credit", items: casts)])

    }
    
    func parseMovie(casts: [Cast]) {
        credits.onNext([SectionModel(model: "credit", items: casts)])
    }
    
    func parseMovie(crews: [Crew]) {
        credits.onNext([SectionModel(model: "credit", items: crews)])
    }
    
    func parseMovieLikeThis(movies: [Movie]) {
        moviesLikeThis.onNext([SectionModel(model: "movie", items: movies)])
    }
    
    func parseKeyword(_ keywords: [Keyword]) {
        self.keywords.onNext(keywords)
    }
    
    func parseGenres(_ genres: [Genre]) {
        self.genres.onNext(genres)
    }
    
    func parseProductionCompanies(_ productionCompanies: [ProductionCompany]) {
        let productionCompanyLogo = productionCompanies.filter { $0.logoPath?.isNotEmpty ?? false }
        self.productionCompanies.onNext(productionCompanyLogo)
        if productionCompanyLogo.isEmpty {
            self.productionCompaniesCollectionViewHeight.onNext(0.0)
        }
    }
    
    func parseReviewAndRelease(movie: Movie) {
        reviewAndRelease.onNext([
            NSLocalizedString("Review (\(movie.reviews?.reviews.count ?? 0))", comment: ""),
            NSLocalizedString("Release Date (\(movie.releaseDates?.results.count ?? 0))", comment: "")
        ])
    }
    
    func parseImages(_ images: [Images]) {
        self.images.onNext(images)
    }
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var repository: TMDBMovieRepository
    
    var movieParser: MovieParser = MovieParser()
    
    var userSetting: TMDBUserSettingProtocol
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { [unowned self] result in
        switch result {
        case .success(let movieResult):
            self.movieParser.parseMovieLikeThis(movies: Array(movieResult.movies))
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
                self.movieParser.parseMovie(movieDetailResult)
                self.movieParser.parseLabel(movie: movieDetailResult, userSetting: self.userSetting)
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
                self.movieParser.parseImages(Array(imageResult.backdrops))
            case .failure(let error):
                debugPrint("Error getting movie images \(movieId): \(error.localizedDescription)")
            }
        }
    }
    
    func getCasts(movieId: Int) {
        self.movieParser.parseMovie(casts: self.repository.getMovieCast(from: movieId))
    }
    
    func getCrews(movieId: Int) {
        self.movieParser.parseMovie(crews: self.repository.getMovieCrew(from: movieId))
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
