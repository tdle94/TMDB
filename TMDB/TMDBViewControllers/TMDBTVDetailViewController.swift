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
import RealmSwift

class TMDBTVDetailViewController: UIViewController {
    var tvId: Int?
    
    var repository: TMDBRepositoryProtocol!
    
    var tvDetailDisplay: TMDBTVDetailDisplay = TMDBTVDetailDisplay()

    var coordinate: MainCoordinator?
    
    // MARK: - data source

    enum NetworkMovieImage: String, CaseIterable {
        case Network = "Network"
    }
    
    enum TVShowSeason: String, CaseIterable {
        case Season = "Season"
    }
    
    enum MatchingTVShow: String, CaseIterable {
        case Matching = "Matching"
    }

    enum TVShowCredit: String, CaseIterable {
        case Credit = "Credit"
    }

    var movieNetworkImageDataSource: UICollectionViewDiffableDataSource<NetworkMovieImage, Networks>!

    var tvShowSeasonDataSource: UITableViewDiffableDataSource<TVShowSeason, Season>!

    var matchingTVShowDataSource: UICollectionViewDiffableDataSource<MatchingTVShow, TVShow>!

    var tvShowCreditDataSource: UICollectionViewDiffableDataSource<TVShowCredit, Object>!

    // MARK: - ui
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    weak var creditHeaderView: TMDBCreditHeaderView?
    weak var addtionalHeaderView: TMDBAdditionalHeaderView?
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var availableLanguageLabel: UILabel!
    @IBOutlet weak var tvShowCreditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    @IBOutlet weak var backdropImageCollectionView: UICollectionView!
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
    @IBOutlet weak var matchingTVShowCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchingTVShowCollectionView: UICollectionView! {
        didSet {
            matchingTVShowCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            matchingTVShowCollectionView.register(TMDBAdditionalHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.additionalHeader)
            matchingTVShowCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            matchingTVShowDataSource = UICollectionViewDiffableDataSource(collectionView: matchingTVShowCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }
            matchingTVShowDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                self.addtionalHeaderView = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.additionalHeader, for: indexPath)) as? TMDBAdditionalHeaderView
                self.addtionalHeaderView?.delegate = self
                return self.addtionalHeaderView
            }
            
            var snapshot = matchingTVShowDataSource.snapshot()
            snapshot.appendSections([.Matching])
            matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var tvShowCreditCollectionView: UICollectionView! {
        didSet {
            tvShowCreditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            tvShowCreditCollectionView.register(TMDBCreditHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.creditMovieHeader)
            tvShowCreditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            tvShowCreditDataSource = UICollectionViewDiffableDataSource(collectionView: tvShowCreditCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }
            tvShowCreditDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.creditHeaderView = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.creditMovieHeader, for: indexPath)) as? TMDBCreditHeaderView
                self.creditHeaderView?.delegate = self
                return self.creditHeaderView
            }
            
            var snapshot = tvShowCreditDataSource.snapshot()
            snapshot.appendSections([.Credit])
            tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        tvDetailDisplay.tvDetailVC = self
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: TMDBUserSetting())
        view.addSubview(loadingView)
        getTVShowDetail()
    }
    
    // MARK: - service
    func getTVShowDetail() {
        guard let id = tvId else { return }
        repository.getTVShowDetail(from: id) { result in
            switch result {
            case .success(let tvShow):
                self.loadingView.removeFromSuperview()
                self.tvDetailDisplay.displayTVShowDetail(tvShow)
            case .failure(let error):
                self.loadingView.showError(true)
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getSimilarMovies() {
        guard let id = tvId else { return }
        repository.getSimilarTVShows(from: id, page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let tvShowResult):
                self.tvDetailDisplay.displayTVShow(Array(tvShowResult.onTV))
            }
        }
    }
    
    func getRecommendMovies() {
        guard let id = tvId else { return }
        repository.getRecommendTVShows(from: id, page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let tvShowResult):
                self.tvDetailDisplay.displayTVShow(Array(tvShowResult.onTV))
            }
        }
    }

    func getTVShowCast() {
        guard let id = tvId else { return }
        let cast = repository.getTVShowCast(from: id)
        tvDetailDisplay.displayCast(cast)
    }

    func getTVShowCrew() {
        guard let id = tvId else { return }
        let crew = repository.getTVShowCrew(from: id)
        tvDetailDisplay.displayCrew(crew)
    }
}

extension TMDBTVDetailViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(at index: Int, text selected: String) {
        if selected == NSLocalizedString("Similar", comment: "") {
            getSimilarMovies()
        } else if selected == NSLocalizedString("Recommend", comment: "") {
            getRecommendMovies()
        } else if selected == NSLocalizedString("Cast", comment: "") {
            getTVShowCast()
        } else if selected == NSLocalizedString("Crew", comment: "") {
            getTVShowCrew()
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

extension TMDBTVDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == matchingTVShowCollectionView {
            let id = matchingTVShowDataSource.snapshot().itemIdentifiers[indexPath.row].id
            coordinate?.navigateToTVShowDetail(tvId: id)
        } else if collectionView == tvShowCreditCollectionView,
                let id = (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Cast)?.id ?? (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Crew)?.id
        {
            coordinate?.navigateToPersonDetail(id: id)
        }
    }
}
