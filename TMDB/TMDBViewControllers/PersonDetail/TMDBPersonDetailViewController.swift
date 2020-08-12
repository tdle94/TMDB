//
//  TMDBPeopleDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 13.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBPersonDetailViewController: UIViewController {
    var personId: Int?
    
    // MARK: - coordinate
    var coordinate: MainCoordinator?

    // MARK: - display
    var personDetail: TMDBPersonDetailDisplay = TMDBPersonDetailDisplay()

    // MARK: - repository
    var repository: TMDBRepository = TMDBRepository.share

    // MARK: - data source
    var appearInDataSource: TMDBCollectionDataSource!

    var personImageDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var appearInCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImageCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImageCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var personImageCollectionView: UICollectionView! {
        didSet {
            personImageCollectionView.collectionViewLayout = Layout.customLayout()
            personImageCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            personImageCollectionView.register(TMDBPreviewHeaderView.self,
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: Constant.Identifier.previewHeader)

            personImageDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: personImageCollectionView)

            personImageDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                             for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Images", comment: "")
                return header
            }

            var snapshot = personImageDataSource.snapshot()
            snapshot.appendSections([.image])
            personImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    weak var appearInHeaderView: TMDBPreviewHeaderView?
    @IBOutlet weak var appearInCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var appearInCollectionView: UICollectionView! {
        didSet {
            appearInCollectionView.collectionViewLayout = Layout.customLayout()
            appearInCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            appearInCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            appearInDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: appearInCollectionView)
            appearInDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                self.appearInHeaderView =
                    (collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) ??
                    collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                            withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                            for: indexPath)) as? TMDBPreviewHeaderView
                self.appearInHeaderView?.label.text = NSLocalizedString("Appear In", comment: "")
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
    
    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
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
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        guard let id = personId else { return }

        if selected == NSLocalizedString("Movies", comment: "") {
            personDetail.displayMovieAppearIn(repository.getMovieCredits(from: id))
        } else if selected == NSLocalizedString("TV Shows", comment: "") {
            personDetail.displayTVShowAppearIn(repository.getTVCredits(from: id))
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
