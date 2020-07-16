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
    var coordinate: MainCoordinator?

    var personDetail: TMDBPersonDetailDisplay = TMDBPersonDetailDisplay()

    var repository: TMDBRepositoryProtocol!

    var personId: Int?
    
    var appearInDataSource: UICollectionViewDiffableDataSource<UUID, Object>!

    // MARK: - ui
    weak var appearInHeaderView: TMDBAppearInHeaderView?
    @IBOutlet weak var appearInCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var appearInCollectionView: UICollectionView! {
        didSet {
            appearInCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            appearInCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            appearInCollectionView.register(TMDBAppearInHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.creditMovieHeader)
            appearInDataSource = UICollectionViewDiffableDataSource(collectionView: appearInCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }
            appearInDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                self.appearInHeaderView =
                    (collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) ??
                    collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                            withReuseIdentifier: Constant.Identifier.creditMovieHeader,
                                                                            for: indexPath)) as? TMDBAppearInHeaderView
                self.appearInHeaderView?.delegate = self
                return self.appearInHeaderView
            }
            
            var snapshot = appearInDataSource.snapshot()
            snapshot.appendSections([UUID()])
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
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

extension TMDBPersonDetailViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(at index: Int, text selected: String) {
        guard let id = personId else { return }

        if selected == NSLocalizedString("Movies", comment: "") {
            personDetail.displayMovieAppearIn(movieCredit: repository.getMovieCredits(from: id))
        } else if selected == NSLocalizedString("TV Shows", comment: "") {
            personDetail.displayTVShowAppearIn(tvCredit: repository.getTVCredits(from: id))
        }
    }
}

extension TMDBPersonDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = appearInDataSource.itemIdentifier(for: indexPath) as? Movie {
            coordinate?.navigateToMovieDetail(id: item.id)
        }
    }
}
