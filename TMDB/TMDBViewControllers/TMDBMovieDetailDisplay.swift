//
//  TMDBMovieDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 6/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieDetailDisplay {
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    weak var movieDetailVC: TMDBMovieDetailViewController?
    
    init(movieDetailVC: TMDBMovieDetailViewController) {
        self.movieDetailVC = movieDetailVC
    }

    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
    
    func displayMovieDetail(movie: Movie) {
        getPosterImage(movie: movie)
        getBackdropImage(movie: movie)
        displayStatus(movie: movie)
        displayOriginalLanguage(movie: movie)
        displayBudget(movie: movie)
        displayRevenue(movie: movie)
        displayTitle(movie: movie)
        displayOverview()
        displayOverviewDetail(movie: movie)
        displayRuntime(movie: movie)
        displayGenere(movie: movie)
        displayKeyword()
        displayCredit(movie)
        displayMatchingMovie(movie)
        displayVideo(movie.videos)
        displayProductionCompanies(movie: movie)
        displayTagLine(movie: movie)
        
        movieDetailVC?.title = movie.title
        movieDetailVC?.additionalInformationTableView.reloadData()
    }
    
    func displayTagLine(movie: Movie) {
        if movie.tagline == "" || movie.tagline == nil {
            movieDetailVC?.taglineLabel.isHidden = true
            movieDetailVC?.taglineTopConstraint.constant = 0
            movieDetailVC?.overviewTopConstraint.constant = 0
        } else {
            movieDetailVC?.taglineLabel.text = movie.tagline
        }
    }
    
    func getPosterImage(movie: Movie) {
        if let posterPath = movie.posterPath, let url = userSetting.getImageURL(from: posterPath) {
            movieDetailVC?.moviePosterImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors { colors in
                    self.movieDetailVC?.moviePosterImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
    }
    
    func getBackdropImage(movie: Movie) {
        if let backdropPath = movie.backdropPath, let url = userSetting.getImageURL(from: backdropPath) {
            movieDetailVC?.backdropImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors() { colors in
                    self.movieDetailVC?.backdropImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
    }

    func displayStatus(movie: Movie) {
        movieDetailVC?.statusLabel.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ",
                                                                         subTitle: movie.status ?? "unknown")
    }

    func displayOriginalLanguage(movie: Movie) {
        movieDetailVC?.originalLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ",
                                                                                   subTitle: Constant.languageCode[movie.originalLanguage] ?? "None")
    }

    func displayBudget(movie: Movie) {
        movieDetailVC?.budgetLabel.attributedText = constructAttrsString(title: NSLocalizedString("Budget", comment: "") + ": ",
                                                                         subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.budget)) ?? "0.0")")
    }

    func displayRevenue(movie: Movie) {
        movieDetailVC?.revenueLabel.attributedText = constructAttrsString(title: NSLocalizedString("Revenue", comment: "") + ": ",
                                                                          subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.revenue)) ?? "0.0")")
    }

    func displayTitle( movie: Movie) {
        movieDetailVC?.titleLabel.attributedText = NSAttributedString(string: movie.originalTitle,
                                                                      attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    func displayOverview() {
        movieDetailVC?.overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                                         attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                          size: UIFont.labelFontSize)!])
    }

    func displayOverviewDetail(movie: Movie) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        if movie.overview == "" {
            movieDetailVC?.overviewLabel.isHidden = true
            movieDetailVC?.overviewTopConstraint.constant = 0
            movieDetailVC?.overviewDetailTopConstraint.constant = 0
            movieDetailVC?.keywordCollectionViewTopConstraint.constant = 0
        }
        
        movieDetailVC?.overviewDetail.attributedText = NSAttributedString(string: movie.overview ?? "",
                                                                          attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                   size: 14)!,
                                                                                       NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                       NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func displayRuntime(movie: Movie) {
        var productionCountries = ""
        var releaseDate = ""

        if movie.productionCountries.count == 1 {
            productionCountries = movie.productionCountries.first!.ios31661
        } else {
            for country in movie.productionCountries {
                if country == movie.productionCountries.last {
                    productionCountries += " \(country.ios31661)"
                } else {
                    productionCountries += "\(country.ios31661), "
                }
            }
        }

        if productionCountries != "" {
            productionCountries = "(\(productionCountries))"
        }

        if let date = movie.releaseDate, date != "" {
            releaseDate = "\u{2022} \(date)"
        }

        movieDetailVC?.runtimeLabel.attributedText = NSAttributedString(string: "\(movie.runtime / 60)h \(movie.runtime % 60)mins \(releaseDate) \(productionCountries)",
                                                                        attributes: [
                                                                           NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                        ])
    }
    
    func displayGenere(movie: Movie) {
        var genres = ""
        if movie.genres.count == 1 {
            genres = movie.genres.first!.name
        } else {
            for genre in movie.genres {
                if genre == movie.genres.last {
                    genres += " \(genre.name)"
                } else {
                    genres += "\(genre.name), "
                }
            }
        }

        movieDetailVC?.generes.attributedText = NSAttributedString(string: genres,
                                                                   attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!])
    }

    func constructAttrsString(title: String, subTitle: String) -> NSAttributedString {
        let firstString = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Circular-Black", size: UIFont.smallSystemFontSize)!,
        ])
        let secondString = NSMutableAttributedString(string: subTitle, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!,
        ])
        firstString.append(secondString)
        return firstString
    }
    
    
    func displayKeyword() {
        movieDetailVC?.keywordCollectionView.reloadData()
        movieDetailVC?.keywordCollectionView.layoutIfNeeded()
        movieDetailVC?.keywordCollectionViewHeightConstraint.constant = movieDetailVC?.keywordCollectionView.contentSize.height ?? 0
    }

    func displayMatchingMovie(_ movie: Movie) {
        guard
            let similar = movie.similar,
            let recommend = movie.recommendations,
            var snapshot = movieDetailVC?.matchingMoviesDataSource.snapshot() else { return }

        if similar.movies.isEmpty, !recommend.movies.isEmpty {
            movieDetailVC?.moreMovieHeader?.segmentControl.removeSegment(at: 0, animated: false)
            movieDetailVC?.moreMovieHeader?.segmentControl.selectedSegmentIndex = 0
            movieDetailVC?.matchingMoviesCollectionView.collectionViewLayout.invalidateLayout()
            snapshot.appendItems(Array(recommend.movies))
            movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
        } else if !similar.movies.isEmpty, recommend.movies.isEmpty {
            movieDetailVC?.moreMovieHeader?.segmentControl.removeSegment(at: 1, animated: false)
            movieDetailVC?.matchingMoviesCollectionView.collectionViewLayout.invalidateLayout()
            snapshot.appendItems(Array(similar.movies))
            movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
        } else if !similar.movies.isEmpty, !recommend.movies.isEmpty {
            displaySimilarMovies(Array(similar.movies))
        } else {
            snapshot.deleteAllItems()
            snapshot.deleteSections([.More])
            movieDetailVC?.matchingMovieCollectionViewHeightContraint.constant = 0
            movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: false)
        }

        movieDetailVC?.matchingMovieCollectionViewHeightContraint.constant = movieDetailVC?.matchingMoviesCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }

    func displayCredit(_ movie: Movie) {
        guard
            let credit = movie.credits,
            var snapshot = movieDetailVC?.creditMovieDataSource.snapshot()
            else { return }

        if credit.cast.isEmpty, !credit.crew.isEmpty {
            movieDetailVC?.creditHeader?.segmentControl.removeSegment(at: 0, animated: false)
            movieDetailVC?.creditHeader?.segmentControl.selectedSegmentIndex = 0
            movieDetailVC?.creditCollectionView.collectionViewLayout.invalidateLayout()
            snapshot.appendItems(Array(credit.crew))
            movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
        } else if credit.crew.isEmpty, !credit.cast.isEmpty {
            movieDetailVC?.creditHeader?.segmentControl.removeSegment(at: 1, animated: false)
            movieDetailVC?.creditCollectionView.collectionViewLayout.invalidateLayout()
            snapshot.appendItems(Array(credit.cast))
            movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
        } else if !credit.cast.isEmpty, !credit.crew.isEmpty {
            displayCast(Array(credit.cast))
        } else {
            snapshot.deleteSections([.Credit])
            movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
        }

        movieDetailVC?.creditCollectionViewHeightConstraint.constant = movieDetailVC?.creditCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }

    func displayVideo(_ videoResult: VideoResult?) {
        guard var snapshot = movieDetailVC?.videoMovieDataSource.snapshot() else { return }
        guard let videoResult = videoResult, !videoResult.videos.isEmpty else {
            snapshot.deleteSections([.Video])
            movieDetailVC?.videoCollectionViewTopConstraint.constant = 0
            movieDetailVC?.videoCollectionViewHeightConstraint.constant = 0
            movieDetailVC?.videoMovieDataSource.apply(snapshot, animatingDifferences: true)
            return
        }
        let videos = Array(videoResult.videos)
        snapshot.appendItems(videos)
        movieDetailVC?.videoMovieDataSource.apply(snapshot, animatingDifferences: true)
        movieDetailVC?.videoCollectionViewHeightConstraint.constant = (movieDetailVC?.videoCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0)/2.5
    }

    func displayCast(_ casts: [Cast]) {
        guard var snapshot = movieDetailVC?.creditMovieDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Credit))
        snapshot.appendItems(casts, toSection: .Credit)
        snapshot.reloadSections([.Credit])
        movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrew(_ crews: [Crew]) {
        guard var snapshot = movieDetailVC?.creditMovieDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Credit))
        snapshot.appendItems(crews, toSection: .Credit)
        snapshot.reloadSections([.Credit])
        movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayRecommendMovies(_ recommendMovies: [Movie]) {
        guard var snapshot = movieDetailVC?.matchingMoviesDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .More))
        snapshot.appendItems(recommendMovies, toSection: .More)
        movieDetailVC?.matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displaySimilarMovies(_ similarMovies: [Movie]) {
        guard var snapshot = movieDetailVC?.matchingMoviesDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .More))
        snapshot.appendItems(similarMovies, toSection: .More)
        movieDetailVC?.matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayProductionCompanies(movie: Movie) {
        guard var snapshot = movieDetailVC?.productionCompanyDataSource.snapshot() else { return }
        if movie.productionCompanies.isEmpty {
            movieDetailVC?.productionCompanyCollectionViewTopConstraint.constant = 0
            movieDetailVC?.productionCompanyCollectionViewHeightConstraint.constant = 0
            return
        }
        let productionCompanies = Array(movie.productionCompanies)
        snapshot.appendSections([.ProductionCompanies])
        snapshot.appendItems(productionCompanies)
        movieDetailVC?.productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
    }
}
