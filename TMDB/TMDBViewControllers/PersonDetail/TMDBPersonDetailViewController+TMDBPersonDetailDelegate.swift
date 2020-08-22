//
//  TMDBPersonDetailViewController+TMDBPersonDetailDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBPersonDetailViewController: TMDBPersonDetailDelegate {
    func displayPerson(person: People) {
        loadingView.removeFromSuperview()
        displayBirthLabel(person: person)
        displayGenderLabel(person: person)
        displayOcuupationLabel(person: person)
        displayAliasLabel(person: person)
        displayProfileImage(person: person)
        displayBiographyDetail(person: person)
        displayCredit(person: person)
        displayPersonImageCollectionView(person: person)
        title = person.name
    }
    
    func displayMovieCredit(movies: [Movie]) {
        var snapshot = appearInDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers)
        snapshot.appendItems(movies)
        appearInCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        appearInDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displayTVShowCredit(tvShows: [TVShow]) {
        var snapshot = appearInDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers)
        snapshot.appendItems(tvShows)
        appearInCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        appearInDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - display subviews

    func displayPersonImageCollectionView(person: People) {
        guard let images = person.images?.profiles else { return }
        var snapshot = personImageDataSource.snapshot()
        if images.isEmpty {
            snapshot.deleteSections([.image])
            personImageCollectionViewHeightConstraint.constant = 0
        } else {
            snapshot.appendItems(Array(images))
        }
        personImageDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovieAppearIn(_ movies: [Movie]) {
        var snapshot = appearInDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers)
        snapshot.appendItems(Array(movies))
        appearInCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        appearInDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayTVShowAppearIn(_ tvShows: [TVShow]) {
        var snapshot = appearInDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers)
        snapshot.appendItems(Array(tvShows))
        appearInCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        appearInDataSource.apply(snapshot, animatingDifferences: true)
    }

    private func displayCredit(person: People) {
        var snapshot = appearInDataSource.snapshot()
        guard
            let movieCredit = person.movieCredits,
            let tvCredit = person.tvCredits
            else { return }

        if movieCredit.cast.isEmpty, tvCredit.cast.isEmpty {
            snapshot.deleteSections(snapshot.sectionIdentifiers)
            appearInDataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        if !movieCredit.cast.isEmpty {
            appearInHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("Movies", comment: ""), at: 0, animated: true)
        }
        
        if !tvCredit.cast.isEmpty {
            appearInHeaderView?.segmentControl.insertSegment(withTitle: NSLocalizedString("TV Shows", comment: ""), at: 1, animated: true)
        }
        
        if appearInHeaderView?.segmentControl.numberOfSegments == 2 || tvCredit.cast.isEmpty {
            displayMovieAppearIn(Array(movieCredit.cast))
        } else if appearInHeaderView?.segmentControl.numberOfSegments == 1 {
            displayTVShowAppearIn(Array(tvCredit.cast))
        }

        appearInCollectionView.collectionViewLayout.invalidateLayout()
        appearInHeaderView?.segmentControl.selectedSegmentIndex = 0
    }

    private func displayBiographyDetail(person: People) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        if person.biography == "" {
            biographyDetailLabel.isHidden = true
            biographyLabel.isHidden = true
            personImageCollectionViewTopConstraint.constant = -30
        }

        biographyDetailLabel.attributedText = NSAttributedString(string: person.biography,
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
            birthLabel.attributedText = constructAttrsString(title: "Born: ", subTitle: birth)
        }
    }

    private func displayGenderLabel(person: People) {
        genderLabel.attributedText = constructAttrsString(title: "Gender: ", subTitle: person.gender == 2 ? NSLocalizedString("Male", comment: "") : NSLocalizedString("Female", comment: ""))
    }

    private func displayOcuupationLabel(person: People) {
        occupationLabel.attributedText = constructAttrsString(title: "Occupation: ", subTitle: person.knownForDepartment)
    }

    private func displayAliasLabel(person: People) {
        let alias = person.alsoKnownAs.joined(separator: ",")
        if alias != "" {
            aliasLabel.attributedText = constructAttrsString(title: "Alias: ", subTitle: alias)
        } else {
            aliasLabel.isHidden = true
        }
    }

    private func displayProfileImage(person: People) {
        guard
            let path = person.profilePath,
            let url = userSetting.getImageURL(from: path) else {
            return
        }
        profileImageView.sd_setImage(with: url)
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
