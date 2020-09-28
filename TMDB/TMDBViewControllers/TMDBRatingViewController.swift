//
//  TMDBRatingViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 9/27/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class TMDBRatingViewController: UIViewController {
    // MARK: - properties
    let repository: TMDBRepository = TMDBRepository.share

    var id: Int?
    var ratingType: RatingType = .movie

    weak var rating: TMDBNotifyRating?

    enum RatingType {
        case movie
        case tvShow
    }

    private lazy var ratingHandler: (Result<RatingResponse, Error>) -> Void = { result in
        switch result {
        case .success(let result):
            self.dismiss(animated: true) {
                self.rating?.notifyRating(message: result.message)
            }
        case .failure(let error):
            debugPrint(error)
            self.view.makeToast(error.localizedDescription)
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = Constant.Color.primaryColor
        navigationItem.rightBarButtonItem?.tintColor = Constant.Color.backgroundColor
    }

    // MARK: - ui
    @IBOutlet weak var ratingView: CosmosView! {
        didSet {
            ratingView.settings.fillMode = .half
            ratingView.settings.minTouchRating = 0.5
        }
    }
        
    // MARK: - user action
    @IBAction func applyRating() {
        switch ratingType {
        case .movie:
            self.repository.postMovieRating(movieId: self.id!, rate: ratingView.rating, completion: ratingHandler)
        case .tvShow:
            self.repository.postTVShowRating(tvId: self.id!, rate: ratingView.rating, completion: ratingHandler)
        }
    }
    
    @IBAction func dismissRating(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
}
