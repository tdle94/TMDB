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
    
    func handleMovieLikeThisSelection(at segment: Int, title: String, movieId: Int)
    func handleCreditSelection(at segment: Int, title: String, movieId: Int)
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
    var credits: BehaviorSubject<[MovieDetailModel]> = BehaviorSubject(value: [])
    
    var missingSimilarMovie: Bool = false
    var missingRecommendMovie: Bool = false
    
    var missingCast: Bool = false
    var missingCrew: Bool = false
    
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
        let moviesLikeThisOne = Array((movie.similar?.movies ?? movie.recommendations?.movies ?? List<Movie>()).map { CustomElementType(identity: $0) })
        var credits = Array(movie.credits?.cast ?? List<Cast>()).map { CustomElementType(identity: $0) }
        
        if credits.isEmpty {
            credits = Array(movie.credits?.crew ?? List<Crew>()).map { CustomElementType(identity: $0) }
        }

        missingSimilarMovie = movie.similar?.movies.isEmpty ?? true
        missingRecommendMovie = movie.recommendations?.movies.isEmpty ?? true
        missingCast = movie.credits?.cast.isEmpty ?? true
        missingCrew = movie.credits?.crew.isEmpty ?? true
        
        if moviesLikeThisOne.isEmpty, credits.isEmpty {
            self.credits.onNext([])
        } else if moviesLikeThisOne.isEmpty {
            self.credits.onNext([
                .Credits(items: credits),
            ])
        } else if credits.isEmpty {
            self.credits.onNext([
                .MoviesLikeThis(items: moviesLikeThisOne),
            ])
        } else {
            self.credits.onNext([
                .Credits(items: credits),
                .MoviesLikeThis(items: moviesLikeThisOne),
            ])
        }
    }
    
    func parseMovie(casts: [Cast]) {
        guard let movieLikeThisModel = try? credits.value().dropFirst() else {
            self.credits.onNext([
                .Credits(items: casts.map { CustomElementType(identity: $0) })
            ])
            return
        }
        
        self.credits.onNext([
            .Credits(items: casts.map { CustomElementType(identity: $0) }),
        ] + movieLikeThisModel)
    }
    
    func parseMovie(crews: [Crew]) {
        guard let movieLikeThisModel = try? credits.value().dropFirst() else {
            self.credits.onNext([
                .Credits(items: crews.map { CustomElementType(identity: $0) })
            ])
            return
        }

        self.credits.onNext([
            .Credits(items: crews.map { CustomElementType(identity: $0) }),
        ] +  movieLikeThisModel)
    }
    
    func parseMovieLikeThis(movies: [Movie]) {
        guard let credit = try? credits.value().first else {
            self.credits.onNext([
                .MoviesLikeThis(items: movies.map { CustomElementType(identity: $0) })
            ])
            return
        }

        switch credit {
        case .Credits(items: _):
            self.credits.onNext([
                credit,
                .MoviesLikeThis(items: movies.map { CustomElementType(identity: $0) })
            ])
        case .MoviesLikeThis(items: _):
            self.credits.onNext([
                credit,
                .MoviesLikeThis(items: movies.map { CustomElementType(identity: $0) })
            ])
        }
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
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { result in
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.movieParser.parseMovie(casts: self.repository.getMovieCast(from: movieId))
        }
    }
    
    func getCrews(movieId: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.movieParser.parseMovie(crews: self.repository.getMovieCrew(from: movieId))
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
    
    func getReviews(movieId: Int) -> [Review] {
        self.repository.getMovieReview(from: movieId)
    }
    
    func handleMovieLikeThisSelection(at segment: Int, title: String, movieId: Int) {
        if segment == 0, title == NSLocalizedString("Similar", comment: "") {
            getSimilarMovies(movieId: movieId)
        } else {
            getRecommendMovies(movieId: movieId)
        }
    }
    
    func handleCreditSelection(at segment: Int, title: String, movieId: Int) {
        if segment == 0, title == NSLocalizedString("Cast", comment: "") {
            getCasts(movieId: movieId)
        } else {
            getCrews(movieId: movieId)
        }
    }
}
