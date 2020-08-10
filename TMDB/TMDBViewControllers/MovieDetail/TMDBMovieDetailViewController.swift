//
//  TMDBMovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 6/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage.SDImageCache

class TMDBMovieDetailViewController: UIViewController {
    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - properties

    var movieId: Int?

    // MARK: - data source
    var videoMovieDataSource: TMDBCollectionDataSource!

    var creditMovieDataSource: TMDBCollectionDataSource!

    var productionCompanyDataSource: TMDBCollectionDataSource!

    var matchingMoviesDataSource: TMDBCollectionDataSource!

    var keywordMovieDataSource: TMDBCollectionDataSource!

    var movieImageDataSource: TMDBCollectionDataSource!

    // MARK: - display
    var movieDetail: TMDBMovieDetailDisplay!

    // MARK: - repository

    var repository: TMDBRepository = TMDBRepository.share

    // MARK: - ui views
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.refreshControl = UIRefreshControl()
            scrollView.refreshControl?.tintColor = Constant.Color.primaryColor
            scrollView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
            scrollView.refreshControl?.addTarget(self, action: #selector(refreshMovieDetail), for: .valueChanged)
        }
    }
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var availableLanguageLabel: UILabel!
    @IBOutlet weak var additionalInformationTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var additionalInformationTableView: UITableView!
    weak var creditHeader: TMDBPreviewHeaderView?
    weak var moreMovieHeader: TMDBPreviewHeaderView?
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchingMovieCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var taglineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewDetailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backdropImageCollectionView: UICollectionView! {
        didSet {
            backdropImageCollectionView.collectionViewLayout = UICollectionViewLayout.imageLayout()
            backdropImageCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)

            movieImageDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.imageCell, collectionView: backdropImageCollectionView)

            var snapshot = movieImageDataSource.snapshot()
            snapshot.appendSections([.image])
            movieImageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var generes: UILabel!
    @IBOutlet weak var keywordCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var keywordCollectionView: UICollectionView! {
        didSet {
            keywordCollectionView.collectionViewLayout = TMDBKeywordLayout(delegate: self)
            keywordCollectionView.register(TMDBKeywordCell.self, forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            videoCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            
            videoMovieDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: videoCollectionView)

            videoMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewHeader, for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Video", comment: "")
                return header
            }
            
            var snapshot = videoMovieDataSource.snapshot()
            snapshot.appendSections([.video])
            videoMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            
            creditMovieDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: creditCollectionView)
            
            creditMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.creditHeader = (collectionView.supplementaryView(forElementKind: kind, at: indexPath)  ??
                                 collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                  withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                                  for: indexPath)) as? TMDBPreviewHeaderView
                self.creditHeader?.label.text = NSLocalizedString("Credit", comment: "")
                self.creditHeader?.delegate = self
                return self.creditHeader
            }
            
            var snapshot = creditMovieDataSource.snapshot()
            snapshot.appendSections([.credit])
            creditMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var matchingMoviesCollectionView: UICollectionView! {
        didSet {
            matchingMoviesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            matchingMoviesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            matchingMoviesCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
            matchingMoviesDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: matchingMoviesCollectionView)

            matchingMoviesDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                self.moreMovieHeader = (collectionView.supplementaryView(forElementKind: kind, at: indexPath) ??
                                        collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                        withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                                        for: indexPath)) as? TMDBPreviewHeaderView
                self.moreMovieHeader?.delegate = self
                self.moreMovieHeader?.label.text = NSLocalizedString("More", comment: "")
                return self.moreMovieHeader
            }

            var snapshot = matchingMoviesDataSource.snapshot()
            snapshot.appendSections([.more])
            matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.2, fractionHeight: 0.4)
            productionCompaniesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            productionCompaniesCollectionView.register(TMDBPreviewHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)

            productionCompanyDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: productionCompaniesCollectionView)
            productionCompanyDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                             for: indexPath) as? TMDBPreviewHeaderView
                header?.label.text = NSLocalizedString("Produce by", comment: "")
                return header
            }

            var snapshot = productionCompanyDataSource.snapshot()
            snapshot.appendSections([.productionCompanies])
            productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var moviePosterImageView: UIImageView! {
        didSet {
            moviePosterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            moviePosterImageView.roundImage()
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetail = TMDBMovieDetailDisplay(movieDetailVC: self)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        contentView.bringSubviewToFront(moviePosterImageView)
        view.addSubview(loadingView)
        scrollView.contentSize = UIScreen.main.bounds.size
        // movie detail
        getMovieDetail()
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }

    // MARK: - service call

    func getMovieCast() {
        guard let id = movieId else { return }
        let casts = repository.getMovieCast(from: id)
        movieDetail.displayCast(casts)
    }

    func getMovieCrew() {
        guard let id = movieId else { return }
        let crews = repository.getMovieCrew(from: id)
        movieDetail.displayCrew(crews)
    }

    func getSimilarMovies() {
        guard let id = movieId else { return }
        repository.getSimilarMovies(from: id, page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let similar):
                self.movieDetail.displayMoreMovie(Array(similar.movies))
            }
        }
    }

    func getRecommendMovies() {
        guard let id = movieId else { return }
        repository.getRecommendMovies(from: id, page: 1) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let recommend):
                self.movieDetail.displayMoreMovie(Array(recommend.movies))
            }
        }
    }

    func getMovieDetail() {
        guard let id = movieId else { return }
        let group = DispatchGroup()
        group.enter()

        repository.getMovieDetail(id: id) { result in
            switch result {
            case .success(let movie):
                group.leave()
                self.movieDetail.displayMovieDetail(movie: movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }

        group.notify(queue: .main) {
            self.repository.getMovieImages(from: id) { result in
                switch result {
                case .success(let imageResult):
                    self.loadingView.removeFromSuperview()
                    self.movieDetail.displayBackdropImages(imageResult)
                case .failure(let error):
                    self.loadingView.showError(true)
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func refreshMovieDetail() {
        guard let id = movieId else { return }
        backdropImageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        repository.refreshMovie(id: id) { result in
            self.scrollView.refreshControl?.endRefreshing()
            switch result {
            case .success(let movie):
                self.movieDetail.displayMovieDetail(movie: movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - segment user interaction
extension TMDBMovieDetailViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(at index: Int, text selected: String) {
        if selected == NSLocalizedString("Cast", comment: "") {
            getMovieCast()
        } else if selected == NSLocalizedString("Crew", comment: "") {
            getMovieCrew()
        } else if selected == NSLocalizedString("Similar", comment: "") {
            getSimilarMovies()
        } else {
            getRecommendMovies()
        }
    }
}

// MARK: - preview poster user interaction
extension TMDBMovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if
            collectionView == matchingMoviesCollectionView,
            let movie = matchingMoviesDataSource.itemIdentifier(for: indexPath) as? Movie
        {
            coordinator?.navigateToMovieDetail(id: movie.id)
        }

        if
            collectionView == videoCollectionView,
            let video = videoMovieDataSource.itemIdentifier(for: indexPath) as? Video,
            let url = TMDBUserSetting().getYoutubeVideoURL(key: video.key)
        {
            coordinator?.navigateToVideoPlayer(with: url)
        }

        if
            collectionView == creditCollectionView,
            let id = (creditMovieDataSource.snapshot().itemIdentifiers[indexPath.row] as? Cast)?.id ?? (creditMovieDataSource.snapshot().itemIdentifiers[indexPath.row] as? Crew)?.id
        {
            coordinator?.navigateToPersonDetail(id: id)
        }
    }
}

// MARK: -  keyword collectionview datasource
extension TMDBMovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let id = movieId else {
            return UICollectionViewCell()
        }

        if
            collectionView == keywordCollectionView,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.keywordCell, for: indexPath) as? TMDBKeywordCell
        {
            let keyword = repository.getMovieKeywords(from: id)[indexPath.row]
            cell.configure(keyword: keyword)
            return cell
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let id = movieId else { return 0 }
        return repository.getMovieKeywords(from: id).count
    }
}

// MARK: - keyword collectionview delegate
extension TMDBMovieDetailViewController: TMDBKeywordLayoutDelegate {
    // dynamic width base on text
    func tagCellLayoutSize(layout: TMDBKeywordLayout, at index: Int) -> CGSize {
        guard let id = movieId else {
            return .zero
        }
        let keyword = repository.getMovieKeywords(from: id)[index]
        let label = UILabel()
        label.text = keyword.name
        return label.intrinsicContentSize
    }
}

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
            let reviewCount = repository.getMovieReview(from: id).count
            cell.textLabel?.text = NSLocalizedString("Review", comment: "") + " (\(reviewCount))"
        } else {
            let releaseDateCount = repository.getMovieReleaseDates(from: id)?.results.count ?? 0
            cell.textLabel?.text = NSLocalizedString("Release Date", comment: "") + " (\(releaseDateCount))"
        }
        return cell
    }
}

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
