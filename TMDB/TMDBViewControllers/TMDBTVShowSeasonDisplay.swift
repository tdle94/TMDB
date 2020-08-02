//
//  TMDBTVShowSeasonDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 02.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTVShowSeasonDisplay {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    weak var tvShowSeasonVC: TMDBTVShowSeasonViewController?
    
    func displaySeason(_ season: Season) {
        tvShowSeasonVC?.title = season.name
        displayPosterImage(season)
        displaySeasonName(season)
        displayAirDateLabel(season)
        displayOverview(season)
    }
    
    func displayPosterImage(_ season: Season) {
        guard
            let path = season.posterPath,
            let url = userSetting.getImageURL(from: path) else { return }

        tvShowSeasonVC?.posterImageView.sd_setImage(with: url)
    }
    
    func displaySeasonName(_ season: Season) {
        tvShowSeasonVC?.seasonNameLabel.attributedText = NSAttributedString(string: season.name,
                                                                            attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }
    
    func displayAirDateLabel(_ season: Season) {
        tvShowSeasonVC?.airDateLabel.attributedText = NSAttributedString(string: "\(season.episodeCount) episodes \u{2022} \(season.airDate ?? "")",
                                                                         attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
    }
    
    func displayOverview(_ season: Season) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        if season.overview == "" {
            tvShowSeasonVC?.overviewLabel.isHidden = true
        }
        tvShowSeasonVC?.overviewLabel.attributedText = NSAttributedString(string: NSLocalizedString("Overview", comment: "") + ": ",
                                                                             attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                              size: UIFont.labelFontSize)!])
        tvShowSeasonVC?.overviewDetailLabel.attributedText = NSAttributedString(string: season.overview,
                                                                              attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                       size: 14)!,
                                                                                           NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                           NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    
    func constructAttrsString(title: String, subTitle: String) -> NSMutableAttributedString {
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
