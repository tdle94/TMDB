//
//  TMDBPersonDetailDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 14.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBPersonDetailDisplay {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    weak var personDetailVC: TMDBPersonDetailViewController?

    func displayPersonDetail(_ person: People) {
        displayBirthLabel(person: person)
        displayGenderLabel(person: person)
        displayOcuupationLabel(person: person)
        displayAliasLabel(person: person)
        displayProfileImage(person: person)
        displayBiographyDetail(person: person)
        displayCredit(person: person)
        displayPersonImageCollectionView(person: person)
        personDetailVC?.title = person.name
    }

    func displayPersonImageCollectionView(person: People) {
        guard
            var snapshot = personDetailVC?.personImageDataSource.snapshot(),
            let images = person.images?.profiles
            else { return }
        
        if images.isEmpty {
            snapshot.deleteSections([.image])
            personDetailVC?.personImageCollectionViewHeightConstraint.constant = 0
        } else {
            snapshot.appendItems(Array(images))
        }
        personDetailVC?.personImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovieAppearIn(_ movies: [Movie]) {
        guard var snapshot = personDetailVC?.appearInDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers)
        snapshot.appendItems(Array(movies))
        personDetailVC?.appearInCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        personDetailVC?.appearInDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayTVShowAppearIn(_ tvShows: [TVShow]) {
        guard var snapshot = personDetailVC?.appearInDataSource.snapshot() else { return }
        snapshot.deleteItems(snapshot.itemIdentifiers)
        snapshot.appendItems(Array(tvShows))
        personDetailVC?.appearInCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        personDetailVC?.appearInDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func displayCredit(person: People) {
        guard var snapshot = personDetailVC?.appearInDataSource.snapshot() else { return }
        guard
            let movieCredit = person.movieCredits,
            let tvCredit = person.tvCredits
            else { return }
        
        if !movieCredit.cast.isEmpty {
            personDetailVC?.appearInHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Movies", comment: ""), at: 0, animated: true)
        }
        
        if !tvCredit.cast.isEmpty {
            personDetailVC?.appearInHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("TV Shows", comment: ""), at: 1, animated: true)
        }
        
        if personDetailVC?.appearInHeaderView?.segmentControl.numberOfSegments == 2 || tvCredit.cast.isEmpty {
            displayMovieAppearIn(Array(movieCredit.cast))
        } else if personDetailVC?.appearInHeaderView?.segmentControl.numberOfSegments == 1 {
            displayTVShowAppearIn(Array(tvCredit.cast))
        } else {
            snapshot.deleteSections(snapshot.sectionIdentifiers)
            personDetailVC?.appearInDataSource.apply(snapshot, animatingDifferences: true)
        }

        personDetailVC?.appearInCollectionView.collectionViewLayout.invalidateLayout()
        personDetailVC?.appearInHeaderView?.segmentControl.selectedSegmentIndex = 0
    }

    private func displayBiographyDetail(person: People) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        if person.biography == "" {
            personDetailVC?.biographyDetailLabel.isHidden = true
            personDetailVC?.biographyLabel.isHidden = true
            personDetailVC?.personImageCollectionViewTopConstraint.constant = -30
        }

        personDetailVC?.biographyDetailLabel.attributedText = NSAttributedString(string: person.biography,
                                                                                attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                         size: 14)!,
                                                                                             NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private func displayBirthLabel(person: People) {
        var birth: String?

        if person.birthday == nil || person.birthday == "" {
            birth = person.placeOfBirth
        } else if person.placeOfBirth == nil || person.placeOfBirth == "" {
            birth = person.birthday
        } else {
            birth = "\(person.birthday!) in \(person.placeOfBirth!)"
        }

        if let birth = birth {
            personDetailVC?.birthLabel.attributedText = constructAttrsString(title: "Born: ", subTitle: birth)
        }
    }

    private func displayGenderLabel(person: People) {
        if person.gender == 2 {
            personDetailVC?.genderLabel.attributedText = constructAttrsString(title: "Gender: ", subTitle: "Male")
        } else {
            personDetailVC?.genderLabel.attributedText = constructAttrsString(title: "Gender: ", subTitle: "Female")
        }
    }

    private func displayOcuupationLabel(person: People) {
        personDetailVC?.occupationLabel.attributedText = constructAttrsString(title: "Occupation: ", subTitle: person.knownForDepartment)
    }

    private func displayAliasLabel(person: People) {
        let alias = person.alsoKnownAs.joined(separator: ",")
        if alias != "" {
            personDetailVC?.aliasLabel.attributedText = constructAttrsString(title: "Alias: ", subTitle: alias)
        } else {
            personDetailVC?.aliasLabel.isHidden = true
        }
    }
    
    private func displayProfileImage(person: People) {
        guard
            let path = person.profilePath,
            let url = userSetting.getImageURL(from: path) else {
            return
        }
        personDetailVC?.profileImageView.sd_setImage(with: url)
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
