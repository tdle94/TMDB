//
//  TMDBAllPopularPeopleController.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllPopularPeopleController: TMDBDisplayAllViewController {
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Popular", comment: "") + " " + NSLocalizedString("People", comment: "")
        presenter.getPopularPeople(page: 1)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let peopleCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == peopleCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), peopleCount != presenter.total {
            presenter.page = presenter.page + 1
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getPopularPeople(page: presenter.page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let person = allDataSource.itemIdentifier(for: indexPath) as? People else { return }
        coordinate?.navigateToPersonDetail(id: person.id)
    }
}
