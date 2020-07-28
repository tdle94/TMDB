//
//  TMDBMovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 6/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SDWebImage.SDImageCache

class TMDBMovieDetailViewController: UIViewController {
    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - properties

    enum ProdcutionCompanySection: String, CaseIterable {
        case ProductionCompanies = "Produced By"
    }

    enum MatchingMovieSection: String, CaseIterable {
        case More = "More"
    }

    enum CreditMovieSection: String, CaseIterable {
        case Credit = "Credit"
    }

    enum VideoMovieSection: String, CaseIterable {
        case Video = "Videos"
    }

    enum KeywordMovieSection: String, CaseIterable {
        case Keyword = "Keyword"
    }

    enum MovieImageSection: String, CaseIterable {
        case Image = "Image"
    }

    var movieId: Int?

    var videoMovieDataSource: UICollectionViewDiffableDataSource<VideoMovieSection, Video>!

    var creditMovieDataSource: UICollectionViewDiffableDataSource<CreditMovieSection, Object>!

    var productionCompanyDataSource: UICollectionViewDiffableDataSource<ProdcutionCompanySection, ProductionCompany>!

    var matchingMoviesDataSource: UICollectionViewDiffableDataSource<MatchingMovieSection, Movie>!

    var keywordMovieDataSource: UICollectionViewDiffableDataSource<KeywordMovieSection, Keyword>!

    var movieImageDataSource: UICollectionViewDiffableDataSource<MovieImageSection, Images>!

    var movieDetail: TMDBMovieDetailDisplay!

    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    // MARK: - repository

    var repository: TMDBRepository!
    
    // MARK: - ui views
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    @IBOutlet weak var backdropPageControl: UIPageControl!
    @IBOutlet weak var availableLanguageLabel: UILabel!
    @IBOutlet weak var additionalInformationTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var additionalInformationTableView: UITableView!
    weak var creditHeader: TMDBCreditHeaderView?
    weak var moreMovieHeader: TMDBAdditionalHeaderView?
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
    @IBOutlet weak var scrollView: UIScrollView!
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

            movieImageDataSource = UICollectionViewDiffableDataSource(collectionView: backdropImageCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.imageCell, for: indexPath) as? TMDBBackdropImageCell
                cell?.configure(image: item)
                return cell
            }
            var snapshot = movieImageDataSource.snapshot()
            snapshot.appendSections([.Image])
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
            videoCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            videoCollectionView.register(TMDBVideoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.videoMovieHeader)
            
            videoMovieDataSource = UICollectionViewDiffableDataSource(collectionView: videoCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }

            videoMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.videoMovieHeader, for: indexPath) as? TMDBVideoHeaderView
                return header
            }
            
            var snapshot = videoMovieDataSource.snapshot()
            snapshot.appendSections([.Video])
            videoMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            creditCollectionView.register(TMDBCreditHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.creditMovieHeader)
            
            creditMovieDataSource = UICollectionViewDiffableDataSource(collectionView: creditCollectionView) { collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: item)
                return cell
            }
            
            creditMovieDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                self.creditHeader = (collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? TMDBCreditHeaderView) ??
                                 (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                  withReuseIdentifier: Constant.Identifier.creditMovieHeader,
                                                                                  for: indexPath) as? TMDBCreditHeaderView)
                self.creditHeader?.delegate = self
                return self.creditHeader
            }
            
            var snapshot = creditMovieDataSource.snapshot()
            snapshot.appendSections([.Credit])
            creditMovieDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var matchingMoviesCollectionView: UICollectionView! {
        didSet {
            matchingMoviesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            matchingMoviesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            matchingMoviesCollectionView.register(TMDBAdditionalHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.additionalHeader)
            
            matchingMoviesDataSource = UICollectionViewDiffableDataSource(collectionView: matchingMoviesCollectionView) { collectionView, indexPath, movie in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: movie)
                return cell
            }

            matchingMoviesDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                self.moreMovieHeader = (collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) ??
                                        collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                        withReuseIdentifier: Constant.Identifier.additionalHeader,
                                                                                        for: indexPath)) as? TMDBAdditionalHeaderView
                self.moreMovieHeader?.delegate = self

                return self.moreMovieHeader
            }

            var snapshot = matchingMoviesDataSource.snapshot()
            snapshot.appendSections([.More])
            matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.3, fractionHeight: 0.3)
            productionCompaniesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            productionCompaniesCollectionView.register(TMDBProduceByHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.movieProduceByHeader)
            
            productionCompanyDataSource = UICollectionViewDiffableDataSource(collectionView: productionCompaniesCollectionView) { collectionView, indexPath, productionCompany in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
                cell?.configure(item: productionCompany)
                return cell
            }
            productionCompanyDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.movieProduceByHeader,
                                                                             for: indexPath) as? TMDBProduceByHeaderView
                return header
            }
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
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource())

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        contentView.bringSubviewToFront(moviePosterImageView)
        contentView.bringSubviewToFront(backdropPageControl)

        view.addSubview(loadingView)
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
        repository.getMovieDetail(id: id) { result in
            switch result {
            case .success(let movie):
                self.loadingView.removeFromSuperview()
                self.movieDetail.displayMovieDetail(movie: movie)
                
                // get movie images. Since movie image with country code does not return all images
                self.repository.getMovieImages(from: id) { result in
                    switch result {
                    case .success(let images):
                        self.movieDetail.displayMovieBackdropImages(images)
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    }
                }

            case .failure(let error):
                self.loadingView.showError(true)
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
            let movie = matchingMoviesDataSource.itemIdentifier(for: indexPath)
        {
            coordinator?.navigateToMovieDetail(id: movie.id)
        }

        if
            collectionView == videoCollectionView,
            let video = videoMovieDataSource.itemIdentifier(for: indexPath),
            let url = userSetting.getYoutubeVideoURL(key: video.key)
        {
            coordinator?.navigateToVideoPlayer(with: url)
        }

        if
            collectionView == creditCollectionView,
            let cast = creditMovieDataSource.itemIdentifier(for: indexPath) as? Cast
        {
            coordinator?.navigateToPersonDetail(id: cast.id)
        }
        
        if
            collectionView == creditCollectionView,
            let crew = creditMovieDataSource.itemIdentifier(for: indexPath) as? Crew
        {
            coordinator?.navigateToPersonDetail(id: crew.id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if backdropImageCollectionView == collectionView {
            backdropPageControl.currentPage = indexPath.row
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
        if let id = movieId {
            let keyword = repository.getMovieKeywords(from: id)[index]
            let label = UILabel()
            label.text = keyword.name
            return label.intrinsicContentSize
        }
        return .zero
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
