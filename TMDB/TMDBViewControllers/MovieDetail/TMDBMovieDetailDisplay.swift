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
        movieDetailVC?.loadingView.removeFromSuperview()
        getPosterImage(movie: movie)
        displayStatus(movie: movie)
        displayOriginalLanguage(movie: movie)
        displayBudget(movie: movie)
        displayRevenue(movie: movie)
        displayTitle(movie: movie)
        displayOverviewDetail(movie: movie)
        displayRuntime(movie: movie)
        displayGenere(movie: movie)
        displayKeyword()
        displayCredit(movie)
        displayMatchingMovie(movie)
        displayVideo(movie.videos)
        displayProductionCompanies(movie: movie)
        displayTagLine(movie: movie)
        displayAvailableLanguageLabel(movie: movie)
        movieDetailVC?.title = movie.title
        movieDetailVC?.additionalInformationTableView.reloadData()
        if movie.keywords?.keywords.isEmpty ?? false {
            movieDetailVC?.additionalInformationTableViewHeightConstraint.constant = -10
        }
    }

    func displayAvailableLanguageLabel(movie: Movie) {
        let languages = Array(movie.spokenLanguages).map { "\($0.name)" }.joined(separator: ", ")
        movieDetailVC?.availableLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Available Languages", comment: "") + ": ", subTitle: languages)
    }

    func displayBackdropImages(_ imageResult: ImageResult) {
        guard var snapshot = movieDetailVC?.movieImageDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .image))
        snapshot.appendItems(Array(imageResult.backdrops))
        movieDetailVC?.movieImageDataSource.apply(snapshot, animatingDifferences: true)
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

    func displayStatus(movie: Movie) {
        movieDetailVC?.statusLabel.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ",
                                                                         subTitle: movie.status ?? "unknown")
    }

    func displayOriginalLanguage(movie: Movie) {
        movieDetailVC?.originalLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ",
                                                                                   subTitle: userSetting.languagesCode.first(where: { $0.iso6391 == movie.originalLanguage })?.name ?? "None")
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

    func displayOverviewDetail(movie: Movie) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        if movie.overview == "" {
            movieDetailVC?.overviewLabel.isHidden = true
            movieDetailVC?.overviewTopConstraint.constant = 0
            movieDetailVC?.overviewDetailTopConstraint.constant = 0
            movieDetailVC?.keywordCollectionViewTopConstraint.constant = -20
        }
        
        movieDetailVC?.overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                                         attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                          size: UIFont.labelFontSize)!])
        movieDetailVC?.overviewDetail.attributedText = NSAttributedString(string: movie.overview ?? "",
                                                                          attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                   size: 14)!,
                                                                                       NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                       NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func displayRuntime(movie: Movie) {
        var releaseDate = ""
        var productionCountries = Array(movie.productionCountries).map { $0 == movie.productionCountries.last || movie.productionCountries.count == 1 ? "\($0.ios31661)" : "\($0.ios31661), " }.joined()

        if let date = movie.releaseDate, date != "" {
            releaseDate = "\u{2022} \(date)"
        }
        
        if productionCountries != "" {
            productionCountries = "(\(productionCountries))"
        }

        movieDetailVC?.runtimeLabel.attributedText = NSAttributedString(string: "\(movie.runtime / 60)h \(movie.runtime % 60)mins \(releaseDate) \(productionCountries)",
                                                                        attributes: [
                                                                           NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                        ])
    }
    
    func displayGenere(movie: Movie) {
        let genres = Array(movie.genres).map { "\($0.name)" }.joined(separator: ", ")
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
        
        if similar.movies.isEmpty, recommend.movies.isEmpty {
            snapshot.deleteSections([.more])
            movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: false)
            return
        }
        
        movieDetailVC?.moreMovieHeader?.segmentControl.removeAllSegments()
        if !similar.movies.isEmpty {
            movieDetailVC?.moreMovieHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Similar", comment: ""), at: 0, animated: true)
        }

        if !recommend.movies.isEmpty {
            movieDetailVC?.moreMovieHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Recommend", comment: ""), at: 1, animated: true)
        }

        if movieDetailVC?.moreMovieHeader?.segmentControl.numberOfSegments == 2 || recommend.movies.isEmpty {
            displayMoreMovie(Array(similar.movies))
        } else if movieDetailVC?.moreMovieHeader?.segmentControl.numberOfSegments == 1 {
            displayMoreMovie(Array(recommend.movies))
        }

        movieDetailVC?.moreMovieHeader?.segmentControl.selectedSegmentIndex = 0
        movieDetailVC?.matchingMoviesCollectionView.collectionViewLayout.invalidateLayout()
        movieDetailVC?.matchingMovieCollectionViewHeightContraint.constant = movieDetailVC?.matchingMoviesCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }

    func displayCredit(_ movie: Movie) {
        guard
            let credit = movie.credits,
            var snapshot = movieDetailVC?.creditMovieDataSource.snapshot()
            else { return }

        if credit.cast.isEmpty, credit.crew.isEmpty {
            snapshot.deleteSections([.credit])
            movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        movieDetailVC?.creditHeader?.segmentControl.removeAllSegments()
        if !credit.cast.isEmpty {
            movieDetailVC?.creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
        }
        
        if !credit.crew.isEmpty {
            movieDetailVC?.creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Crew", comment: ""), at: 1, animated: true)
        }
        
        if movieDetailVC?.creditHeader?.segmentControl.numberOfSegments == 2 || credit.crew.isEmpty {
            displayCast(Array(credit.cast), reloadSection: false)
        } else if movieDetailVC?.creditHeader?.segmentControl.numberOfSegments == 1 {
            displayCrew(Array(credit.crew), reloadSection: false)
        }

        movieDetailVC?.creditHeader?.segmentControl.selectedSegmentIndex = 0
        movieDetailVC?.creditCollectionView.collectionViewLayout.invalidateLayout()
        movieDetailVC?.creditCollectionViewHeightConstraint.constant = movieDetailVC?.creditCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
    }

    func displayVideo(_ videoResult: VideoResult?) {
        guard var snapshot = movieDetailVC?.videoMovieDataSource.snapshot() else { return }
        guard let videoResult = videoResult, !videoResult.videos.isEmpty else {
            snapshot.deleteSections([.video])
            movieDetailVC?.videoCollectionViewTopConstraint.constant = 0
            movieDetailVC?.videoCollectionViewHeightConstraint.constant = 0
            movieDetailVC?.videoMovieDataSource.apply(snapshot, animatingDifferences: true)
            return
        }
        let videos = Array(videoResult.videos)
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .video))
        snapshot.appendItems(videos)
        movieDetailVC?.videoMovieDataSource.apply(snapshot, animatingDifferences: true)
        movieDetailVC?.videoCollectionViewHeightConstraint.constant = (movieDetailVC?.videoCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0)/2
    }

    func displayCast(_ casts: [Cast], reloadSection: Bool = true) {
        guard var snapshot = movieDetailVC?.creditMovieDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts, toSection: .credit)
        movieDetailVC?.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        if casts.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrew(_ crews: [Crew], reloadSection: Bool = true) {
        guard var snapshot = movieDetailVC?.creditMovieDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews, toSection: .credit)
        movieDetailVC?.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        if crews.count == 1, reloadSection {
            snapshot.reloadSections([.credit])
        }
        movieDetailVC?.creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMoreMovie(_ movie: [Movie]) {
        guard var snapshot = movieDetailVC?.matchingMoviesDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .more))
        snapshot.appendItems(movie, toSection: .more)
        movieDetailVC?.matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        movieDetailVC?.matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayProductionCompanies(movie: Movie) {
        guard var snapshot = movieDetailVC?.productionCompanyDataSource.snapshot() else { return }
        if movie.productionCompanies.isEmpty {
            movieDetailVC?.productionCompanyCollectionViewTopConstraint.constant = 0
            movieDetailVC?.productionCompanyCollectionViewHeightConstraint.constant = 0
            snapshot.deleteSections([.productionCompanies])
            movieDetailVC?.productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .productionCompanies))
        snapshot.appendItems(Array(movie.productionCompanies))
        movieDetailVC?.productionCompanyDataSource.apply(snapshot, animatingDifferences: true)

        if movie.productionCompanies.contains(where: { $0.logoPath != nil }) {
            movieDetailVC?.productionCompanyCollectionViewHeightConstraint.constant = (movieDetailVC?.productionCompaniesCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0)/3
        } else {
            movieDetailVC?.productionCompanyCollectionViewHeightConstraint.constant = (movieDetailVC?.productionCompaniesCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0)/5
        }
    }
}
