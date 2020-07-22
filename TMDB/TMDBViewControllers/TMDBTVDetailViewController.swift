//
//  TMDBTVDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 7/20/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMDBTVDetailViewController: UIViewController {
    var tvId: Int?
    
    var repository: TMDBRepositoryProtocol!
    
    var tvDetailDisplay: TMDBTVDetailDisplay = TMDBTVDetailDisplay()
    
    // MARK: - data source

    enum NetworkMovieImage: String, CaseIterable {
        case Network = "Network"
    }
    
    enum TVShowSeason: String, CaseIterable {
        case Season = "Season"
    }

    var movieNetworkImageDataSource: UICollectionViewDiffableDataSource<NetworkMovieImage, Networks>!

    var tvShowSeasonDataSource: UITableViewDiffableDataSource<TVShowSeason, Season>!

    // MARK: - ui
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    @IBOutlet weak var backdropImageCollectionView: TMDBImageCollectionView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var numberOfSeasonLabel: UILabel!
    @IBOutlet weak var numberOfEpisodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var keywordCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout(delegate: self)
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var networkCollectionView: UICollectionView! {
        didSet {
            networkCollectionView.collectionViewLayout = UICollectionViewLayout.imageLayout(fractionWidth: 0.2, fractionHeight: 1, scrollBehavior: .continuous)
            networkCollectionView.register(TMDBNetworkImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
            movieNetworkImageDataSource = UICollectionViewDiffableDataSource(collectionView: networkCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.imageCell, for: indexPath) as? TMDBNetworkImageCell
                cell?.configure(networks: item)
                return cell
            }
            var snapshot = movieNetworkImageDataSource.snapshot()
            snapshot.appendSections([.Network])
            movieNetworkImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var tvShowSeaonTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tvShowSeasonTableView: UITableView! {
        didSet {
            
            tvShowSeasonDataSource = UITableViewDiffableDataSource(tableView: tvShowSeasonTableView) { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.tvShowSeasonCell, for: indexPath)
                cell.textLabel?.text = item.name
                cell.detailTextLabel?.text = item.overview
                return cell
            }

            var snapshot = tvShowSeasonDataSource.snapshot()
            snapshot.appendSections([.Season])
            tvShowSeasonDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        tvDetailDisplay.tvDetailVC = self
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: TMDBUserSetting())
        getMovieDetail()
    }
    
    // MARK: - service
    func getMovieDetail() {
        guard let id = tvId else { return }
        repository.getTVShowDetail(from: id) { result in
            switch result {
            case .success(let tvShow):
                self.tvDetailDisplay.displayTVShowDetail(tvShow)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

extension TMDBTVDetailViewController: TMDBKeywordLayoutDelegate {
    // dynamic width base on text
    func tagCellLayoutSize(layout: TMDBKeywordLayout, at index: Int) -> CGSize {
        if let id = tvId {
            let keyword = repository.getTVShowKeywords(from: id)[index]
            let label = UILabel()
            label.text = keyword.name
            return label.intrinsicContentSize
        }
        return .zero
    }
}

extension TMDBTVDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let id = tvId else {
            return UICollectionViewCell()
        }

        if
            collectionView == keywordCollectionView,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.keywordCell, for: indexPath) as? TMDBKeywordCell
        {
            let keyword = repository.getTVShowKeywords(from: id)[indexPath.row]
            cell.configure(keyword: keyword)
            return cell
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let id = tvId else { return 0 }
        return repository.getTVShowKeywords(from: id).count
    }
}
