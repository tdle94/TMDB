//
//  TMDBPeopleDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 13.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TMDBPersonDetailViewController: UIViewController {
    var personDetail: TMDBPersonDetailDisplay = TMDBPersonDetailDisplay()

    var repository: TMDBRepositoryProtocol!

    var personId: Int?
    
    enum AppearInSection: String, CaseIterable {
        case Movie = "Movie"
    }
    
    var appearInDataSource: UICollectionViewDiffableDataSource<AppearInSection, Object>!

    // MARK: - ui
    @IBOutlet weak var appearInCollectionView: UICollectionView! {
        didSet {
            appearInCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            appearInCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            appearInCollectionView.register(TMDBCreditHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.creditMovieHeader)
            appearInDataSource = UICollectionViewDiffableDataSource(collectionView: appearInCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }
            appearInDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                            withReuseIdentifier: Constant.Identifier.creditMovieHeader,
                                                                            for: indexPath) as? TMDBCreditHeaderView
                return header
            }
            
            var snapshot = appearInDataSource.snapshot()
            snapshot.appendSections([.Movie])
            appearInDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var biographyDetailLabel: UILabel!
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
