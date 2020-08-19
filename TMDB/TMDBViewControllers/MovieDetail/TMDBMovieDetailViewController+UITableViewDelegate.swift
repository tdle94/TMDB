//
//  TMDBMovieDetailViewController+UITableViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBMovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = movieId else { return }
        if indexPath.row == 0 {
            coordinator?.navigateToReview(reivew: repository.getMovieReview(from: id))
        } else {
            coordinator?.navigateToCompleteReleaseDates(movieId: id)
        }
    }
}
