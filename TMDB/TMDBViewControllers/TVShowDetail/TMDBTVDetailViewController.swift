//
//  TMDBTVDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 7/20/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBTVDetailViewController: UIViewController {
    // MARK: - properties
    var tvId: Int?
    
    // MARK: - repository
    var repository: TMDBRepository = TMDBRepository.share

    // MARK: - display
    var tvDetailDisplay: TMDBTVDetailDisplay = TMDBTVDetailDisplay()

    // MARK: - coordinate
    var coordinate: MainCoordinator?

    // MARK: - data source

    var movieNetworkImageDataSource: TMDBCollectionDataSource!

    var tvShowSeasonDataSource: TMDBTableDataSource!

    var matchingTVShowDataSource: TMDBCollectionDataSource!

    var tvShowCreditDataSource: TMDBCollectionDataSource!

    var tvShowVideoDataSource: TMDBCollectionDataSource!

    var tvShowCreatorDataSrouce: TMDBCollectionDataSource!

    var tvShowBackdropImageDataSource: TMDBCollectionDataSource!

    // MARK: - ui
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.refreshControl = UIRefreshControl()
            scrollView.refreshControl?.tintColor = Constant.Color.primaryColor
            scrollView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")

            scrollView.refreshControl?.addTarget(self, action: #selector(refreshTVShowDetail), for: .valueChanged)
        }
    }
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    weak var creditHeaderView: TMDBPreviewHeaderView?
    weak var addtionalHeaderView: TMDBPreviewHeaderView?
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            posterImageView.roundImage()
        }
    }
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var availableLanguageLabel: UILabel!
    @IBOutlet weak var tvShowCreditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var numberOfSeasonLabel: UILabel!
    @IBOutlet weak var numberOfEpisodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var keywordCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = UICollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
            tvShowBackdropImageDataSource = TMDBCollectionDataSource(collectionView: backdropImageCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.imageCell, for: indexPath) as? TMDBBackdropImageCell
                cell?.configure(image: item as! Images)
                return cell
            }

            var snapshot = tvShowBackdropImageDataSource.snapshot()
            snapshot.appendSections([.backdrop])
            tvShowBackdropImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            videoCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)

            tvShowVideoDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.preview, collectionView: videoCollectionView)
            tvShowVideoDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Video", comment: "")
                return header
            }
            var snapshot = tvShowVideoDataSource.snapshot()
            snapshot.appendSections([.video])
            tvShowVideoDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
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
            movieNetworkImageDataSource = TMDBCollectionDataSource(collectionView: networkCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.imageCell, for: indexPath) as? TMDBNetworkImageCell
                cell?.configure(networks: item as! Networks)
                return cell
            }
            var snapshot = movieNetworkImageDataSource.snapshot()
            snapshot.appendSections([.network])
            movieNetworkImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var tvShowSeaonTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tvShowSeasonTableView: UITableView! {
        didSet {
            tvShowSeasonTableView.register(TMDBCustomTableViewCell.self, forCellReuseIdentifier: Constant.Identifier.tvShowSeasonCell)
            tvShowSeasonDataSource = TMDBTableDataSource(tableView: tvShowSeasonTableView) { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.tvShowSeasonCell, for: indexPath) as? TMDBCustomTableViewCell
                let season = item as? Season
                cell?.configure(text: season?.name, detailText: season?.overview, imagePath: season?.posterPath)
                return cell
            }

            var snapshot = tvShowSeasonDataSource.snapshot()
            snapshot.appendSections([.season])
            tvShowSeasonDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var matchingTVShowCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchingTVShowCollectionView: UICollectionView! {
        didSet {
            matchingTVShowCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            matchingTVShowCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            matchingTVShowCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            matchingTVShowDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.preview, collectionView: matchingTVShowCollectionView)
            matchingTVShowDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.addtionalHeaderView = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath)) as? TMDBPreviewHeaderView
                self.addtionalHeaderView?.label.text = NSLocalizedString("More", comment: "")
                self.addtionalHeaderView?.delegate = self
                return self.addtionalHeaderView
            }
            
            var snapshot = matchingTVShowDataSource.snapshot()
            snapshot.appendSections([.matching])
            matchingTVShowDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var tvShowCreditCollectionView: UICollectionView! {
        didSet {
            tvShowCreditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            tvShowCreditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            tvShowCreditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            tvShowCreditDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.preview, collectionView: tvShowCreditCollectionView)
            tvShowCreditDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.creditHeaderView = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ?? collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath)) as? TMDBPreviewHeaderView
                self.creditHeaderView?.label.text = NSLocalizedString("Credit", comment: "")
                self.creditHeaderView?.delegate = self
                return self.creditHeaderView
            }
            
            var snapshot = tvShowCreditDataSource.snapshot()
            snapshot.appendSections([.credit])
            tvShowCreditDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creatorCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var creatorCollectionView: UICollectionView! {
        didSet {
            creatorCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            creatorCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            creatorCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            tvShowCreatorDataSrouce = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.preview, collectionView: creatorCollectionView)
            tvShowCreatorDataSrouce.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Creator", comment: "")
                return header
            }

            var snapshot = tvShowCreatorDataSrouce.snapshot()
            snapshot.appendSections([.creator])
            tvShowCreatorDataSrouce.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        tvDetailDisplay.tvDetailVC = self
        view.addSubview(loadingView)
        getTVShowDetail()
    }

    override func viewDidLayoutSubviews() {
        tvShowSeaonTableViewHeightConstraint.constant = tvShowSeasonTableView.contentSize.height
    }

    // MARK: - service

    @objc func refreshTVShowDetail() {
        guard let id = tvId else { return }
        backdropImageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        repository.refreshTVShow(id: id) { result in
            self.scrollView.refreshControl?.endRefreshing()
            switch result {
            case .success(let tvShow):
                self.tvDetailDisplay.displayTVShowDetail(tvShow)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func getTVShowDetail() {
        guard let id = tvId else { return }
        let group = DispatchGroup()
        group.enter()

        repository.getTVShowDetail(from: id) { result in
            self.scrollView.refreshControl?.endRefreshing()
            switch result {
            case .success(let tvShow):
                group.leave()
                self.tvDetailDisplay.displayTVShowDetail(tvShow)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    
        group.notify(queue: .main) {
            self.repository.getTVShowImages(from: id) { result in
                switch result {
                case .failure(let error):
                    self.loadingView.showError(true)
                    debugPrint(error.localizedDescription)
                case .success(let imageResult):
                    self.loadingView.removeFromSuperview()
                    self.tvDetailDisplay.displayBackdropImages(imageResult)
                }
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

    @IBAction func reviewButtonTap() {
        guard let id = tvId else { return }
        let reviews = repository.getTVShowReviews(from: id)
        coordinate?.navigateToReview(reivew: reviews)
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
        if
            collectionView == matchingTVShowCollectionView,
            let id = (matchingTVShowDataSource.snapshot().itemIdentifiers[indexPath.row] as? TVShow)?.id {

            coordinate?.navigateToTVShowDetail(tvId: id)
        }

        if
            collectionView == tvShowCreditCollectionView,
            let id = (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Cast)?.id ?? (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Crew)?.id
        {
            coordinate?.navigateToPersonDetail(id: id)
        }

        if
            collectionView == videoCollectionView,
            let video = tvShowVideoDataSource.itemIdentifier(for: indexPath) as? Video,
            let url = TMDBUserSetting().getYoutubeVideoURL(key: video.key) {

                coordinate?.navigateToVideoPlayer(with: url)
        }
        
        if
            collectionView == creatorCollectionView,
            let id = (tvShowCreatorDataSrouce.itemIdentifier(for: indexPath) as? CreatedBy)?.id {
            
            coordinate?.navigateToPersonDetail(id: id)
        }
    }
}

extension TMDBTVDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = tvId else { return }
        if
            tableView == tvShowSeasonTableView,
            let seasonNumber = (tvShowSeasonDataSource.snapshot().itemIdentifiers(inSection: .season)[indexPath.row] as? Season)?.number {
            coordinate?.navigateToTVShowSeasonDetail(tvId: id, seasonNumber: seasonNumber)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
