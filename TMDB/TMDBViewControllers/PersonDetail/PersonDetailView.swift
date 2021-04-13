//
//  PersonDetailView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class PersonDetailView: UIViewController {
    var viewModel: PersonDetailViewModelProtocol
    
    var id: Int?
    
    var delegate: PersonDetailViewDelegate?

    // MARK: - datasource
    let creditDataSource: RxCollectionViewSectionedReloadDataSource<PersonDetailModel> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell: TMDBCellConfig? = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBCellConfig
        cell?.configure(item: item.identity)
        return cell as! UICollectionViewCell
    })
    
    // MARK: - constraints
    @IBOutlet weak var deathdateTop: NSLayoutConstraint!
    @IBOutlet weak var creditCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var homepageTop: NSLayoutConstraint!
    @IBOutlet weak var posterImageViewTop: NSLayoutConstraint!

    // MARK: - views
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var deathdateLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var homapageLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var ratingLabel: TMDBCircleUserRating!
    @IBOutlet weak var creditCollectionView: UICollectionView! {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(widthDimension: 0.2, heightDimension: 0.43)
            } else {
                creditCollectionView.collectionViewLayout = CollectionViewLayout.customLayout(heightDimension: 0.86)
            }
            
            creditCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            creditCollectionView.register(TMDBPersonCreditHeaderView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: Constant.Identifier.previewHeader)
            
            creditCollectionView
                .rx
                .modelSelected(CustomElementType.self)
                .subscribe { item in
                    if let movie = item.element?.identity as? Movie {
                        self.delegate?.navigateToMovieDetail(movieId: movie.id)
                    } else if let tvShow = item.element?.identity as? TVShow {
                        self.delegate?.navigateToTVShowDetail(tvShowId: tvShow.id)
                    }
                }
                .disposed(by: rx.disposeBag)
            
            creditDataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                             for: indexPath) as! TMDBPersonCreditHeaderView
                
                if header.segmentControl.selectedSegmentIndex == -1 {
                    header.segmentControl.selectedSegmentIndex = 0
                    
                    header
                        .segmentControl
                        .rx
                        .value
                        .changed
                        .subscribe { event in
                            guard let index = event.element, let personId = self.id else {
                                return
                            }
                            
                            self.creditCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                            
                            if index == 0, header.segmentControl.titleForSegment(at: 0) == NSLocalizedString("Movies", comment: "") {
                                self.viewModel.getMoviesAppearIn(personId: personId)
                            } else {
                                self.viewModel.getTVShowsAppearIn(personId: personId)
                            }
                        }
                        .disposed(by: self.rx.disposeBag)
                }
                return header
            }
        }
    }
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.roundImage()
            profileImageView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.parallaxHeader.view = profileCollectionView
        }
    }
    @IBOutlet weak var profileCollectionView: UICollectionView! {
        didSet {
            profileCollectionView.collectionViewLayout = CollectionViewLayout.imageLayout()
            profileCollectionView.register(TMDBBackdropImageCell.self, forCellWithReuseIdentifier: Constant.Identifier.imageCell)
        }
    }
    
    
    // MARK: - init
    init(viewModel: PersonDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: PersonDetailView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setBackArrowIcon()
        setupBinding()

        if let personId = id {
            viewModel.getPersonDetail(id: personId)
        }
    }
}

extension PersonDetailView {

    func setupBinding() {
        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)
        
        // scrollview binding
        scrollView.animateNavBar(safeAreaInsetTop: view.safeAreaInsets.top,
                                 navigationController: navigationController)

        // bind person detail result
        viewModel
            .personDetail
            .subscribe { event in
                guard let person = event.element else {
                    return
                }
                
                if
                    let path = person.profilePath,
                    let url = self.viewModel.userSetting.getImageURL(from: path) {
                    self.profileImageView.sd_setImage(with: url)
                }
                
                if person.deathday?.isEmpty ?? true {
                    self.deathdateTop.constant = 0
                }
                
                if person.homepage?.isEmpty ?? true {
                    self.homepageTop.constant = 0
                }
                
                self.ratingLabel.rating = person.popularity
                self.title = person.name
            }
            .disposed(by: rx.disposeBag)

        // bind profile collection view
        viewModel
            .profileCollectionImages
            .bind(to: profileCollectionView.rx.items(cellIdentifier: Constant.Identifier.imageCell)) { _, image, cell in
                (cell as? TMDBBackdropImageCell)?.configure(item: image)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .profileCollectionImages
            .subscribe { event in
                self.scrollView.parallaxHeader.dots = event.element?.count ?? 0
            }
            .disposed(by: rx.disposeBag)
        
        profileCollectionView
            .rx
            .didEndDisplayingCell
            .subscribe { cell, indexPath in
                guard let index = self.profileCollectionView.indexPathsForVisibleItems.first?.row else {
                    return
                }
                self.scrollView.parallaxHeader.selectDot(at: index)
            }
            .disposed(by: rx.disposeBag)
        
        // credit binding
        viewModel
            .credits
            .bind(to: creditCollectionView.rx.items(dataSource: creditDataSource))
            .disposed(by: rx.disposeBag)
        
        creditCollectionView
            .rx
            .willDisplaySupplementaryView
            .observeOn(MainScheduler.asyncInstance)
            .subscribe { event in
                if let header = event.element?.supplementaryView as? TMDBPersonCreditHeaderView {
                    if !self.viewModel.isThereMovie {
                        header.segmentControl.removeSegment(at: 0, animated: false)
                        header.segmentControl.selectedSegmentIndex = 0
                    } else if !self.viewModel.isThereTVShow {
                        header.segmentControl.removeSegment(at: 1, animated: false)
                    }
                    
                    self.viewModel.resetCreditHeaderState()
                }
            }
            .disposed(by: rx.disposeBag)
        
        // bind label
        viewModel
            .personName
            .bind(to: personNameLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .personBirthDay
            .bind(to: birthdateLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .gender
            .bind(to: genderLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .personDeathDay
            .bind(to: deathdateLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .occupation
            .bind(to: occupationLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .imdb
            .bind(to: imdbLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .alias
            .bind(to: aliasLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .homepage
            .bind(to: homapageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
    }
}
