//
//  DisplayAllViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBDisplayAllViewController: UIViewController, UICollectionViewDelegate, TMDBFilterDelegate {
    // MARK: - presenter
    lazy var presenter: TMDBAllPresenter = TMDBAllPresenter(delegate: self)

    // MARK: - coordinator
    var coordinate: Coordinator?

    // MARK: - data source
    lazy var allDataSource: TMDBCollectionDataSource = TMDBCollectionDataSource(cellIdentifier: Constant.Identifier.previewItem, collectionView: collectionView)

    // MARK: - ui
    weak var footerLoadingView: TMDBFooterLoadingView?
    var loadingView: TMDBLoadingView = UINib(nibName: "TMDBLoadingView", bundle: nil)
                                        .instantiate(withOwner: nil, options: nil).first as! TMDBLoadingView
    var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: CollectionViewLayout.noHeaderTwoItemsPerRowLayout())

    init() {
        super.init(nibName: nil, bundle: nil)
        // set up collection view
        collectionView.backgroundColor = Constant.Color.backgroundColor
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "TMDBFooterLoadingView", bundle: nil),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: Constant.Identifier.previewFooter)
        collectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil),
                      forCellWithReuseIdentifier: Constant.Identifier.previewItem)
        
        // setup data source
        allDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            self.footerLoadingView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constant.Identifier.previewFooter, for: indexPath) as? TMDBFooterLoadingView
            return self.footerLoadingView
        }
        var snapshot = allDataSource.snapshot()
        snapshot.appendSections([.all])
        allDataSource.apply(snapshot, animatingDifferences: true)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]

        view.backgroundColor = Constant.Color.backgroundColor
        view.addSubview(collectionView)
        view.addSubview(loadingView)

        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }

    func filter(query: DiscoverQuery) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
        var snapshot = allDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .all))
        allDataSource.apply(snapshot, animatingDifferences: true)
        view.addSubview(loadingView)
    }
}
