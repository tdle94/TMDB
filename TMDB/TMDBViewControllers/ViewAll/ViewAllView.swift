//
//  ViewAllView.swift
//  TMDB
//
//  Created by Tuyen Le on 4/20/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxDataSources
import RealmSwift
import RxSwift

class ViewAllView: UIViewController {
    var viewModel: ViewAllViewModelProtocol
    
    weak var delegate: AppCoordinator?
    
    var loadIndicatorView: UICollectionReusableView?
    
    var viewAllDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Object>> = RxCollectionViewSectionedReloadDataSource(configureCell: { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath)
        (cell as? TMDBPreviewItemCell)?.configure(item: item)
        return cell
    })
    
    var backgroundLabel: UILabel = UILabel()

    
    @IBOutlet weak var viewAllCollectionView: UICollectionView! {
        didSet {
            viewAllCollectionView.collectionViewLayout = CollectionViewLayout.discoveryEntityLayout()
            viewAllCollectionView.register(UINib(nibName: String(describing: TMDBPreviewItemCell.self), bundle: nil),
                                           forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            viewAllCollectionView.register(UINib(nibName: String(describing: LoadingIndicatorView.self), bundle: nil),
                                           forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                           withReuseIdentifier: Constant.Identifier.cell)
            viewAllCollectionView.backgroundView = backgroundLabel
            backgroundLabel.textAlignment = .center
            
            viewAllDataSource.configureSupplementaryView = { _, collectionView, _, indexPath in
                if let view = self.loadIndicatorView {
                    return view
                }
                
                self.loadIndicatorView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                         withReuseIdentifier: Constant.Identifier.cell,
                                                                                         for: indexPath)
                return self.loadIndicatorView!
            }
        }
    }
    
    init(viewModel: ViewAllViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ViewAllView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setBackArrowIcon()
        title = viewModel.title
        self.setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.resetNavBar()
    }
}

extension ViewAllView {
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
        
        // collection view
        viewModel
            .items
            .bind(to: viewAllCollectionView.rx.items(dataSource: viewAllDataSource))
            .disposed(by: rx.disposeBag)
        
        // select item
        viewAllCollectionView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.delegate?.navigateWith(obj: self.viewAllDataSource.sectionModels.first?.items[indexPath.row])
            })
            .disposed(by: rx.disposeBag)
        
        // at bottom
        viewAllCollectionView
            .rx
            .didScroll
            .skip(1)
            .filter { _ in
                return self.viewAllCollectionView.isAtBottom
            }
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                self.viewModel.getNextPage()
            })
            .disposed(by: rx.disposeBag)
        
        viewAllCollectionView
            .rx
            .willDisplaySupplementaryView
            .take(1)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { supplementary, _, _ in
                let footer = supplementary as! LoadingIndicatorView
                self.viewModel
                    .loadingIndicator
                    .bind(to: footer.loadingIndicator.rx.isAnimating)
                    .disposed(by: self.rx.disposeBag)
                
                self.viewModel
                    .hideEndOfResult
                    .bind(to: footer.label.rx.isHidden)
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)
    }
}
