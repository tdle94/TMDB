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

    var repository: TMDBRepository = TMDBRepository.share

    var personId: Int?
    
    enum AppearInSection: String, CaseIterable {
        case appearIn = "Appear In"
    }

    enum PersonImageSection: String, CaseIterable {
        case image = "Image"
    }

    var appearInDataSource: UICollectionViewDiffableDataSource<AppearInSection, Object>!

    var personImageDataSource: UICollectionViewDiffableDataSource<PersonImageSection, Images>!

    // MARK: - ui
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var appearInCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImageCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImageCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImageCollectionView: UICollectionView! {
        didSet {
            personImageCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            personImageCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            personImageCollectionView.register(TMDBPersonImageHeaderView.self,
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: Constant.Identifier.personImageHeader)

            personImageDataSource = UICollectionViewDiffableDataSource(collectionView: personImageCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }

            personImageDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.personImageHeader,
                                                                             for: indexPath) as? TMDBPersonImageHeaderView
                return header
            }

            var snapshot = personImageDataSource.snapshot()
            snapshot.appendSections([.image])
            personImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
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
            snapshot.appendSections([.appearIn])
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
        personDetail.personDetailVC = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]

        view.addSubview(loadingView)
        // get person detail
        getPersonDetail()
    }

    // MARK: - services
    func getPersonDetail() {
        guard let id = personId else { return }
        repository.getPersonDetail(id: id) { result in
            switch result {
            case .failure(let error):
                self.loadingView.showError(true)
                debugPrint(error.localizedDescription)
            case .success(let person):
                self.loadingView.removeFromSuperview()
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
        } else if let item = appearInDataSource.itemIdentifier(for: indexPath) as? TVShow {
            coordinate?.navigateToTVShowDetail(tvId: item.id)
        }
    }
}
