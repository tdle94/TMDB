//
//  TMDBMovieDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 6/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBMovieDetailDisplayProtocol {
    func displayStatus(label: UILabel, movie: Movie)
    func displayOriginalLanguage(label: UILabel, movie: Movie)
    func displayBudget(label: UILabel, movie: Movie)
    func displayRevenue(label: UILabel, movie: Movie)
    func displayTitle(label: UILabel, movie: Movie)
    func displayOverview(label: UILabel)
    func displayOverviewDetail(label: UILabel, movie: Movie)
    func displayRuntime(label: UILabel, movie: Movie)
    func displayGenere(label: UILabel, movie: Movie)
}

class TMDBMovieDetailDisplay: TMDBMovieDetailDisplayProtocol {
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }

    func displayStatus(label: UILabel, movie: Movie) {
        label.attributedText = constructAttrsString(title: NSLocalizedString("Status", comment: "") + ": ", subTitle: movie.status ?? "unknown")
    }
    
    func displayOriginalLanguage(label: UILabel, movie: Movie) {
        label.attributedText = constructAttrsString(title: NSLocalizedString("Original Language", comment: "") + ": ", subTitle: Constant.languageCode[movie.originalLanguage] ?? "None")
    }
    
    func displayBudget(label: UILabel, movie: Movie) {
        label.attributedText = constructAttrsString(title: NSLocalizedString("Budget", comment: "") + ": ", subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.budget)) ?? "0.0")")
    }
    
    func displayRevenue(label: UILabel, movie: Movie) {
        label.attributedText = constructAttrsString(title: NSLocalizedString("Revenue", comment: "") + ": ", subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.revenue)) ?? "0.0")")
    }
    
    func displayTitle(label: UILabel, movie: Movie) {
        label.attributedText = NSAttributedString(string: movie.originalTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }
    
    func displayOverview(label: UILabel) {
        label.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ", attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!])
    }
    
    func displayOverviewDetail(label: UILabel, movie: Movie) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        label.attributedText = NSAttributedString(string: movie.overview ?? "", attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    func displayRuntime(label: UILabel, movie: Movie) {
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
        
        label.attributedText = NSAttributedString(string: "\(movie.runtime / 60)h \(movie.runtime % 60)mins \(releaseDate) \(productionCountries)",
                                                         attributes: [
                                                            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!,
                                                            NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                         ])
    }
    
    func displayGenere(label: UILabel, movie: Movie) {
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
        label.attributedText = NSAttributedString(string: genres, attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!])
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
}
