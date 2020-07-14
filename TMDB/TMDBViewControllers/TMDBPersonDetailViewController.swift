//
//  TMDBPeopleDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 13.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBPersonDetailViewController: UIViewController {
    var personDetail: TMDBPersonDetailDisplay = TMDBPersonDetailDisplay()

    var repository: TMDBRepositoryProtocol!

    var personId: Int?

    // MARK: - ui
    @IBOutlet weak var biographyDetailLabel: UILabel!
    @IBOutlet weak var appearInCollectionView: UICollectionView!
    @IBOutlet weak var biographyLabel: UILabel! {
        didSet {
            biographyLabel.attributedText = NSAttributedString(string: NSLocalizedString("Biography", comment: "") + ": ",
                                                               attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                                size: UIFont.labelFontSize)!])
        }
    }
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.roundImage()
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: TMDBUserSetting())
        personDetail.personDetailVC = self
        getPersonDetail()
    }

    // MARK: - services
    func getPersonDetail() {
        guard let id = personId else { return }
        repository.getPersonDetail(id: id) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let person):
                self.personDetail.displayPersonDetail(person)
            }
        }
    }
}

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
        personDetailVC?.title = person.name
    }
    
    func displayBiographyDetail(person: People) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        
        if person.biography == "" {
            personDetailVC?.biographyDetailLabel.isHidden = true
            personDetailVC?.biographyLabel.isHidden = true
        }

        personDetailVC?.biographyDetailLabel.attributedText = NSAttributedString(string: person.biography,
                                                                                attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book",
                                                                                                         size: 14)!,
                                                                                             NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                                                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    func displayBirthLabel(person: People) {
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
