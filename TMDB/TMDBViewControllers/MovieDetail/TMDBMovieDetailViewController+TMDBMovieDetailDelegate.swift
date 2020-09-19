//
//  TMDBMovieDetailViewController+TMDBMovieDetailDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBMovieDetailViewController: TMDBMovieDetailDelegate {
    func displayMovieDetail(_ movie: Movie) {

        presenter.getBackdropImage(movieId: movieId!)

        scrollView.refreshControl?.endRefreshing()

        title = movie.title
        
        loadingView.removeFromSuperview()

        getPosterImage(movie: movie)
        displayStatus(movie: movie)
        displayOriginalLanguage(movie: movie)
        displayBudget(movie: movie)
        displayRevenue(movie: movie)
        displayTitle(movie: movie)
        displayOverviewDetail(movie: movie)
        displayRuntime(movie: movie)
        displayGenere(movie: movie)
        displayCredit(movie: movie)
        displayMatchingMovie(movie: movie)
        displayVideo(videoResult: movie.videos)
        displayProductionCompanies(movie: movie)
        displayTagLine(movie: movie)
        displayAvailableLanguageLabel(movie: movie)
        displayKeyword(movie: movie)
        additionalInformationTableView.reloadData()
    }
    
    func displayMovieCasts(_ casts: [Cast]) {
        var snapshot = creditMovieDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(casts, toSection: .credit)
        if casts.count == 1 {
            snapshot.reloadSections([.credit])
        }
        creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayMovieCrews(_ crews: [Crew]) {
        var snapshot = creditMovieDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .credit))
        snapshot.appendItems(crews, toSection: .credit)
        if crews.count == 1 {
            snapshot.reloadSections([.credit])
        }
        creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovies(_ movies: [Movie]) {
        var snapshot = matchingMoviesDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .more))
        snapshot.appendItems(.init(), toSection: .more) // for view all card
        snapshot.appendItems(movies, toSection: .more)
        matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayBackdropImage(_ images: [Images]) {
        var snapshot = movieImageDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .image))
        snapshot.appendItems(images)
        movieImageDataSource.apply(snapshot, animatingDifferences: true)
        backdropImageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }

    func displayError(_ error: Error) {
        loadingView.showError(true)
    }

    // MARK: - display subviews
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }

    func displayAvailableLanguageLabel(movie: Movie) {
        let languages = Array(movie.spokenLanguages).map { "\($0.name)" }.joined(separator: ", ")
        availableLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Available Languages", comment: "") + ": ", subTitle: languages)
    }

    func displayBackdropImages(_ imageResult: ImageResult) {
        var snapshot = movieImageDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .image))
        snapshot.appendItems(Array(imageResult.backdrops))
        movieImageDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayTagLine(movie: Movie) {
        if movie.tagline == "" || movie.tagline == nil {
            taglineLabel.isHidden = true
            taglineTopConstraint.constant = 0
            overviewTopConstraint.constant = 0
        } else {
            taglineLabel.text = movie.tagline
        }
    }
    
    func getPosterImage(movie: Movie) {
        if let posterPath = movie.posterPath, let url = userSetting.getImageURL(from: posterPath) {
            moviePosterImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors { colors in
                    self.moviePosterImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
    }

    func displayStatus(movie: Movie) {
        statusLabel.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ",
                                                          subTitle: movie.status ?? "unknown")
    }

    func displayOriginalLanguage(movie: Movie) {
        originalLanguageLabel.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ",
                                                                    subTitle: userSetting.languagesCode.first(where: { $0.iso6391 == movie.originalLanguage })?.name ?? "None")
    }

    func displayBudget(movie: Movie) {
        budgetLabel.attributedText = constructAttrsString(title: NSLocalizedString("Budget", comment: "") + ": ",
                                                          subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.budget)) ?? "0.0")")
    }

    func displayRevenue(movie: Movie) {
        revenueLabel.attributedText = constructAttrsString(title: NSLocalizedString("Revenue", comment: "") + ": ",
                                                           subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.revenue)) ?? "0.0")")
    }

    func displayTitle( movie: Movie) {
        titleLabel.attributedText = NSAttributedString(string: movie.originalTitle,
                                                       attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }

    func displayOverviewDetail(movie: Movie) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        if movie.overview == "" {
            overviewLabel.isHidden = true
            overviewTopConstraint.constant = 0
            overviewDetailTopConstraint.constant = 0
            keywordCollectionViewTopConstraint.constant = -20
        }
        
        overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                          attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                           size: UIFont.labelFontSize)!])
        overviewDetail.attributedText = NSAttributedString(string: movie.overview ?? "",
                                                           attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
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

        runtimeLabel.attributedText = NSAttributedString(string: "\(movie.runtime / 60)h \(movie.runtime % 60)mins \(releaseDate) \(productionCountries)",
                                                            attributes: [
                                                                        NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: 14)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                        ])
    }
    
    func displayGenere(movie: Movie) {
        let genres = Array(movie.genres).map { "\($0.name)" }.joined(separator: ", ")
        generes.attributedText = NSAttributedString(string: genres,
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
    
    
    func displayKeyword(movie: Movie) {
        if movie.keywords?.keywords.isEmpty ?? false {
            additionalInformationTableViewHeightConstraint.constant = -10
        }
        keywordCollectionView.reloadData()
        keywordCollectionView.layoutIfNeeded()
        keywordCollectionViewHeightConstraint.constant = keywordCollectionView.contentSize.height
    }

    func displayMatchingMovie(movie: Movie) {
        guard
            let similar = movie.similar,
            let recommend = movie.recommendations else { return }

        var snapshot = matchingMoviesDataSource.snapshot()

        if similar.movies.isEmpty, recommend.movies.isEmpty {
            snapshot.deleteSections([.more])
            matchingMoviesDataSource.apply(snapshot, animatingDifferences: false)
            matchingMovieCollectionViewHeightContraint.constant = 0
            return
        }
        
        moreMovieHeader?.segmentControl.removeAllSegments()
        if !similar.movies.isEmpty {
            moreMovieHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Similar", comment: ""), at: 0, animated: true)
        }

        if !recommend.movies.isEmpty {
            moreMovieHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Recommend", comment: ""), at: 1, animated: true)
        }

        if moreMovieHeader?.segmentControl.numberOfSegments == 2 || recommend.movies.isEmpty {
            displayMoreMovie(movie: Array(similar.movies))
        } else if moreMovieHeader?.segmentControl.numberOfSegments == 1 {
            displayMoreMovie(movie: Array(recommend.movies))
        }

        moreMovieHeader?.segmentControl.selectedSegmentIndex = 0
        matchingMoviesCollectionView.collectionViewLayout.invalidateLayout()
        matchingMovieCollectionViewHeightContraint.constant = matchingMoviesCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

    func displayCredit(movie: Movie) {
        guard let credit = movie.credits else { return }
        
        var snapshot = creditMovieDataSource.snapshot()

        if credit.cast.isEmpty, credit.crew.isEmpty {
            snapshot.deleteSections([.credit])
            creditMovieDataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        creditHeader?.segmentControl.removeAllSegments()
        if !credit.cast.isEmpty {
            creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Cast", comment: ""), at: 0, animated: true)
        }
        
        if !credit.crew.isEmpty {
            creditHeader?.segmentControl.insertSegment(withTitle: NSLocalizedString("Crew", comment: ""), at: 1, animated: true)
        }
        
        if creditHeader?.segmentControl.numberOfSegments == 2 || credit.crew.isEmpty {
            displayMovieCasts(Array(credit.cast))
        } else if creditHeader?.segmentControl.numberOfSegments == 1 {
            displayMovieCrews(Array(credit.crew))
        }

        creditHeader?.segmentControl.selectedSegmentIndex = 0
        creditCollectionView.collectionViewLayout.invalidateLayout()
        creditCollectionViewHeightConstraint.constant = creditCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

    func displayVideo(videoResult: VideoResult?) {
        var snapshot = videoMovieDataSource.snapshot()
        guard let videoResult = videoResult, !videoResult.videos.isEmpty else {
            snapshot.deleteSections([.video])
            videoCollectionViewTopConstraint.constant = 0
            videoCollectionViewHeightConstraint.constant = 0
            videoMovieDataSource.apply(snapshot, animatingDifferences: true)
            return
        }
        let videos = Array(videoResult.videos)
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .video))
        snapshot.appendItems(videos)
        videoMovieDataSource.apply(snapshot, animatingDifferences: true)
        videoCollectionViewHeightConstraint.constant = videoCollectionView.collectionViewLayout.collectionViewContentSize.height/2
    }

    func displayMoreMovie(movie: [Movie]) {
        var snapshot = matchingMoviesDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .more))
        snapshot.appendItems([.init()], toSection: .more)
        snapshot.appendItems(movie, toSection: .more)
        matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayProductionCompanies(movie: Movie) {
        var snapshot = productionCompanyDataSource.snapshot()
        if movie.productionCompanies.isEmpty {
            productionCompanyCollectionViewTopConstraint.constant = 0
            productionCompanyCollectionViewHeightConstraint.constant = 0
            snapshot.deleteSections([.productionCompanies])
            productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .productionCompanies))
        snapshot.appendItems(Array(movie.productionCompanies))
        productionCompanyDataSource.apply(snapshot, animatingDifferences: true)

        if movie.productionCompanies.contains(where: { $0.logoPath != nil }) {
            productionCompanyCollectionViewHeightConstraint.constant = productionCompaniesCollectionView.collectionViewLayout.collectionViewContentSize.height/3
        } else {
            productionCompanyCollectionViewHeightConstraint.constant = productionCompaniesCollectionView.collectionViewLayout.collectionViewContentSize.height/5
        }
    }
}
