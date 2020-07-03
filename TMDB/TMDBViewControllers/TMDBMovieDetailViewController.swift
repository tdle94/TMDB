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
import SDWebImage

class TMDBMovieDetailViewController: UIViewController {
    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - properties

    enum Section: String, CaseIterable {
        case ProductionCompanies = "Produced By"
    }

    enum MatchingMovieSection: String, CaseIterable {
        case More = "More"
    }

    enum CreditMovieSection: String, CaseIterable {
        case Credit = "Credit"
    }

    var movieId: Int?
    
    var creditMovieDataSource: UICollectionViewDiffableDataSource<CreditMovieSection, Object>!

    var productionCompanyDataSource: UICollectionViewDiffableDataSource<Section, ProductionCompany>!

    var matchingMoviesDataSource: UICollectionViewDiffableDataSource<MatchingMovieSection, Object>!

    var movieDetail: TMDBMovieDetailDisplayProtocol = TMDBMovieDetailDisplay()

    // MARK: - repository
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    var repository: TMDBRepositoryProtocol!
    
    // MARK: - ui views
    weak var creditHeader: TMDBCreditHeaderView?
    weak var moreMovieHeader: TMDBMoreMovieHeaderView?
    @IBOutlet weak var matchingMovieCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var taglineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewDetailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompaniesCollectionViewTopConstraint: NSLayoutConstraint!
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
    @IBOutlet weak var backdropImageView: UIImageView! {
        didSet {
            backdropImageView.layer.borderWidth = 1
            backdropImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
    }
    @IBOutlet weak var generes: UILabel!
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            creditCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            creditCollectionView.register(TMDBCreditHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.creditMovieHeader)
        }
    }
    @IBOutlet weak var matchingMoviesCollectionView: UICollectionView! {
        didSet {
            matchingMoviesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            matchingMoviesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            matchingMoviesCollectionView.register(TMDBMoreMovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.moreMovieHeader)
        }
    }
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.3, fractionHeight: 0.3)
            productionCompaniesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            productionCompaniesCollectionView.register(TMDBProduceByHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.movieProduceByHeader)
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
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: userSetting)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        contentView.bringSubviewToFront(moviePosterImageView)
        configureProductionCompaniesDataSource()
        configureMatchingMoviesDataSource()
        configureCreditMovieDataSource()
        getMovieDetail()
        getSimilarMovies(shouldGetRecommend: true)
        getMovieCast()
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }

    // MARK: - configuration
    
    func configureCreditMovieDataSource() {
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

    func configureMatchingMoviesDataSource() {
        matchingMoviesDataSource = UICollectionViewDiffableDataSource(collectionView: matchingMoviesCollectionView) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as? TMDBPreviewItemCell
            cell?.configure(item: movie)
            return cell
        }

        matchingMoviesDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            self.moreMovieHeader = (collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? TMDBMoreMovieHeaderView) ??
                             (collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                              withReuseIdentifier: Constant.Identifier.moreMovieHeader,
                                                                              for: indexPath) as? TMDBMoreMovieHeaderView)
            self.moreMovieHeader?.delegate = self

            return self.moreMovieHeader
        }

        var snapshot = matchingMoviesDataSource.snapshot()
        snapshot.appendSections([.More])
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func configureProductionCompaniesDataSource() {
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

    // MARK: - service call
    
    func getMovieCast() {
        guard let id = movieId else { return }

        repository.getMovieCredit(from: id) { result in
            switch result {
            case .success(let creditResult):
                if creditResult.cast.isEmpty && creditResult.crew.isEmpty {
                    var snapshot = self.creditMovieDataSource.snapshot()
                    snapshot.deleteSections([.Credit])
                    snapshot.reloadSections([.Credit])
                    self.creditCollectionViewHeightContraint.constant = 0
                    self.creditMovieDataSource.apply(snapshot)
                } else if creditResult.cast.isEmpty && !creditResult.crew.isEmpty {
                    self.creditHeader?.segmentControl.removeSegment(at: 0, animated: false)
                    self.creditHeader?.segmentControl.selectedSegmentIndex = 0
                    self.creditCollectionView.collectionViewLayout.invalidateLayout()
                    self.displayCrew(creditResult)
                } else if creditResult.crew.isEmpty && !creditResult.cast.isEmpty {
                    self.creditHeader?.segmentControl.removeSegment(at: 1, animated: false)
                    self.creditCollectionView.collectionViewLayout.invalidateLayout()
                    self.displayCast(creditResult)
                } else {
                    self.displayCast(creditResult)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getMovieCrew() {
        guard let id = movieId else { return }
        repository.getMovieCredit(from: id) { result in
            switch result {
            case .success(let creditResult):
                self.displayCrew(creditResult)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func getMovieDetail() {
        guard let id = movieId else { return }
        repository.getMovieDetail(id: id) { result in
            switch result {
            case .success(let movie):
                self.displayMovieDetail(movie)
                self.displayProductionCompanies(movie: movie)
                self.getPosterImage(movie: movie)
                self.getBackdropImage(movie: movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func getSimilarMovies(shouldGetRecommend: Bool = false) {
        guard let id = movieId else { return }

        repository.getSimilarMovies(from: id, page: 1) { result in
            switch result {
            case .success(let movieResult):
                if movieResult.movies.isEmpty {
                    self.moreMovieHeader?.segmentControl.removeSegment(at: 0, animated: false)
                    self.moreMovieHeader?.segmentControl.selectedSegmentIndex = 0
                    self.matchingMoviesCollectionView.collectionViewLayout.invalidateLayout()
                    if shouldGetRecommend {
                        self.getRecommendMovies(shouldDisplay: true)
                    }
                } else {
                    self.displaySimilarMovies(movieResult)
                    if shouldGetRecommend {
                        self.getRecommendMovies(shouldDisplay: false)
                    }
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getRecommendMovies(shouldDisplay: Bool = true) {
        guard let id = movieId else { return }

        repository.getRecommendMovies(from: id, page: 1) { result in
            switch result {
            case .success(let movieResult):
                if movieResult.movies.isEmpty {
                    if self.moreMovieHeader?.segmentControl.numberOfSegments == 2 {
                        self.moreMovieHeader?.segmentControl.removeSegment(at: 1, animated: false)
                        self.matchingMoviesCollectionView.collectionViewLayout.invalidateLayout()
                    } else {
                        self.matchingMovieCollectionViewHeightContraint.constant = 0
                        self.moreMovieHeader?.segmentControl.removeSegment(at: 0, animated: false)
                        var snapshot = self.matchingMoviesDataSource.snapshot()
                        snapshot.deleteSections([.More])
                        self.matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
                    }
                } else if shouldDisplay {
                    self.displayRecommendMovies(movieResult)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func getPosterImage(movie: Movie) {
        if let posterPath = movie.posterPath, let url = userSetting.getImageURL(from: posterPath) {
            self.moviePosterImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors { colors in
                    self.moviePosterImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
    }
    
    func getBackdropImage(movie: Movie) {
        if let backdropPath = movie.backdropPath, let url = userSetting.getImageURL(from: backdropPath) {
            self.backdropImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors() { colors in
                    self.backdropImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
    }
    // MARK: - display

    func displayCast(_ credit: CreditResult) {
        var snapshot = creditMovieDataSource.snapshot()
        let casts = Array(credit.cast)
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Credit))
        snapshot.appendItems(casts, toSection: .Credit)
        creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayCrew(_ credit: CreditResult) {
        var snapshot = creditMovieDataSource.snapshot()
        let crews = Array(credit.crew)
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .Credit))
        snapshot.appendItems(crews, toSection: .Credit)
        creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        creditMovieDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayRecommendMovies(_ popularMovie: MovieResult) {
        var snapshot = matchingMoviesDataSource.snapshot()
        let recommendMovies = Array(popularMovie.movies)
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .More))
        snapshot.appendItems(recommendMovies, toSection: .More)
        matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displaySimilarMovies(_ popularMovie: MovieResult) {
        var snapshot = matchingMoviesDataSource.snapshot()
        let similarMovies = Array(popularMovie.movies)
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .More))
        snapshot.appendItems(similarMovies, toSection: .More)
        matchingMoviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayProductionCompanies(movie: Movie) {
        var snapshot = productionCompanyDataSource.snapshot()
        if movie.productionCompanies.isEmpty {
            productionCompanyCollectionViewTopConstraint.constant = 0
            productionCompanyCollectionViewHeightConstraint.constant = 0
            return
        }
        let productionCompanies = Array(movie.productionCompanies)
        snapshot.appendSections([.ProductionCompanies])
        snapshot.appendItems(productionCompanies)
        productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovieDetail(_ movie: Movie) {
        if movie.overview == nil || movie.overview == "" {
            overviewDetailTopConstraint.constant = 0
            productionCompaniesCollectionViewTopConstraint.constant = 0
            overviewTopConstraint.constant = 0
            overviewLabel.isHidden = true
            overviewDetail.isHidden = true
        }
        
        if movie.tagline == nil || movie.tagline == "" {
            taglineTopConstraint.constant = 0
            taglineLabel.isHidden = true
        }

        title = movie.originalTitle
        taglineLabel.text = movie.tagline
        
        if movie.tagline == "" {
            taglineTopConstraint.constant = 0
        }

        movieDetail.displayTitle(label: titleLabel, movie: movie)
        movieDetail.displayBudget(label: budgetLabel, movie: movie)
        movieDetail.displayGenere(label: generes, movie: movie)
        movieDetail.displayOriginalLanguage(label: originalLanguageLabel, movie: movie)
        movieDetail.displayOverview(label: overviewLabel)
        movieDetail.displayOverviewDetail(label: overviewDetail, movie: movie)
        movieDetail.displayRevenue(label: revenueLabel, movie: movie)
        movieDetail.displayRuntime(label: runtimeLabel, movie: movie)
        movieDetail.displayStatus(label: statusLabel, movie: movie)
        movieDetail.displayTitle(label: titleLabel, movie: movie)
    }
}

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

extension TMDBMovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TMDBPreviewItemCell
        
        for item in matchingMoviesDataSource.snapshot().itemIdentifiers {
            if let movie = item as? Movie, movie.originalTitle == cell?.title.text {
                coordinator?.navigateToMovieDetail(id: movie.id)
                break
            }
        }
    }
}
