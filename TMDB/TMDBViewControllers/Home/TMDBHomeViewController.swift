//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import SDWebImage.SDImageCache

class TMDBHomeViewController: UIViewController {
    // MARK: - presenter
    lazy var presenter: TMDBHomePresenter = TMDBHomePresenter(delegate: self)

    // MARK: - user setting
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    // MARK: - data source
    var dataSource: TMDBCollectionDataSource!
    
    // MARK: - coordinator
    var coordinate: MainCoordinator?

    // MARK: - ui
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = CollectionViewLayout.customLayout()
            collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            collectionView.register(TMDBTrendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.trendPreviewHeader)
            collectionView.register(TMDBPopularHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.popularPreviewHeader)
            collectionView.register(TMDBMovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.moviePreviewHeader)
            collectionView.register(TMDBTVShowHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader)
            
            dataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: collectionView)
            dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
                let header: TMDBPreviewHeaderView?
                if indexPath.section == 0 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.popularPreviewHeader,
                                                                             for: indexPath) as? TMDBPopularHeaderView

                } else if indexPath.section == 1 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.trendPreviewHeader,
                                                                             for: indexPath) as? TMDBTrendHeaderView
                } else if indexPath.section == 2 {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.moviePreviewHeader,
                                                                             for: indexPath) as? TMDBMovieHeaderView
                } else {
                    header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: Constant.Identifier.tvShowPreviewHeader,
                                                                             for: indexPath) as? TMDBTVShowHeaderView
                }
                header?.delegate = self
                return header
            }

            var snapshot = dataSource.snapshot()
            snapshot.appendSections([.popular, .trending, .movie, .tvShow])
            dataSource.apply(snapshot)
        }
    }

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Home", comment: "")
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        configureLanguageAndRegion()

        presenter.getPopularMovie(page: 1)
        presenter.getTrend(page: 1, time: .today)
        presenter.getTopRatedMovie(page: 1)
        presenter.getTopRatedTVShow(page: 1)
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
}

// MARK: - language and region
extension TMDBHomeViewController {
    // MARK: - configure language and region
    @objc func configureLanguageAndRegion() {
        navigationItem.rightBarButtonItems = nil

        // language
        let button = UIButton()
        button.setTitle(NSLocale.current.languageCode?.uppercased(), for: .normal)
        button.addTarget(self, action: #selector(openSetting), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = Constant.Color.backgroundColor.cgColor
        button.layer.cornerRadius = 5
        button.showsTouchWhenHighlighted = true
        let languageSetting = UIBarButtonItem(customView: button)

        // region
        if let region = NSLocale.current.regionCode {
            let regionFlag = UIImage(named: "CountryFlags/\(userSetting.countriesCode.first(where: { $0.iso31661 == region })?.name ?? "")")?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFill)?.withRenderingMode(.alwaysOriginal)
            let regionSetting = UIBarButtonItem(image: regionFlag, style: .plain, target: self, action: #selector(openSetting))
            navigationItem.setRightBarButtonItems([
                languageSetting,
                regionSetting
            ], animated: false)
        }
        
    }

    @objc func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
