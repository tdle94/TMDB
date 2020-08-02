//
//  TMDBTVShowSeasonViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 01.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMDBTVShowSeasonViewController: UIViewController {
    var tvId: Int?

    var seasonNumber: Int?

    var coordinate: MainCoordinator?
    
    var repository: TMDBRepository = TMDBRepository.share
    
    var tvShowSeasonDisplay: TMDBTVShowSeasonDisplay = TMDBTVShowSeasonDisplay()
    
    // MARK: - ui
    @IBOutlet weak var scrollView: UIScrollView!
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        tvShowSeasonDisplay.tvShowSeasonVC = self
        view.addSubview(loadingView)
        getSeason()
    }
    
    // MARK: - service
    func getSeason() {
        guard let id = tvId, let number = seasonNumber else { return }
        repository.getTVShowSeasonDetail(from: id, seasonNumber: number) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.loadingView.showError(true)
            case .success(let season):
                self.loadingView.removeFromSuperview()
                self.tvShowSeasonDisplay.displaySeason(season)
            }
        }
    }
}
