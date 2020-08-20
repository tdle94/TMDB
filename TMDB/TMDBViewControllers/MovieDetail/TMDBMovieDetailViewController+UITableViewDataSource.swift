//
//  TMDBMovieDetailViewController+UITableViewDataSource.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

// MARK: - uitableview datasource & delegate for additionalTableView (Release date and Review)
extension TMDBMovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let id = movieId else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath)
        cell.indentationLevel = 1
        if indexPath.row == 0 {
            let reviewCount = presenter.repository.getMovieReview(from: id).count
            cell.textLabel?.text = NSLocalizedString("Review", comment: "") + " (\(reviewCount))"
        } else {
            let releaseDateCount = presenter.repository.getMovieReleaseDates(from: id)?.results.count ?? 0
            cell.textLabel?.text = NSLocalizedString("Release Date", comment: "") + " (\(releaseDateCount))"
        }
        return cell
    }
}
