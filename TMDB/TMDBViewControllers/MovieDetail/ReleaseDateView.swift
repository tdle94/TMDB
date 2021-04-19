//
//  ReleaseDateView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/31/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class ReleaseDateView: UIViewController {
    var movieId: Int?

    var viewModel: ReleaseDateViewModelProtocol

    weak var delegate: CommonNavigation?

    // MARK: - views
    let emptyLabel = UILabel()
    @IBOutlet weak var releaseDateTableView: UITableView! {
        didSet {
            releaseDateTableView.rowHeight = 80
            releaseDateTableView.tableFooterView = UIView()
            releaseDateTableView.backgroundColor = Constant.Color.backgroundColor
            releaseDateTableView.register(UINib(nibName: "TitleWithSubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.cell)
            
            emptyLabel.setHeader(title: "No results")
            emptyLabel.textAlignment = .center
            releaseDateTableView.backgroundView = emptyLabel
        }
    }
    
    // MARK:  - init
    init(viewModel: ReleaseDateViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ReleaseDateView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.tintColor = Constant.Color.backgroundColor
        navigationItem.searchController?.searchBar.backgroundColor = Constant.Color.primaryColor
        navigationItem.searchController?.searchBar.placeholder = NSLocalizedString("Country", comment: "")
        (navigationItem.searchController?.searchBar.value(forKey: "searchField") as? UITextField)?.textColor = Constant.Color.backgroundColor
        (navigationItem.searchController?.searchBar.value(forKey: "searchField") as? UITextField)?.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Country", comment: ""), attributes: [ NSAttributedString.Key.foregroundColor : Constant.Color.backgroundColor ])
        navigationItem.searchController?.searchBar.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal),
                                                           for: .search,
                                                           state: .normal)
        
        setupBinding()
        title = NSLocalizedString("Release Date", comment: "")
        if let id = movieId {
            viewModel.getReleaseDates(movieId: id)
        }
    }
}

extension ReleaseDateView {
    func setupBinding() {
        navigationController?.resetNavBar()
        navigationItem.setBackArrowIcon()
        
        // bind search bar
        navigationItem
            .searchController?
            .searchBar
            .rx
            .text
            .orEmpty
            .filter { !$0.isEmpty && !$0.trimmingCharacters(in: .whitespaces).isEmpty && !$0.last!.isWhitespace && !$0.first!.isWhitespace }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { query in
                self.viewModel.filter(query: query)
            })
            .disposed(by: rx.disposeBag)
        
        navigationItem
            .searchController?
            .searchBar
            .rx
            .cancelButtonClicked
            .asDriver()
            .drive(onNext: { _ in
                self.viewModel.resetFilter()
            })
            .disposed(by: rx.disposeBag)

        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)

        viewModel
            .releaseDates
            .bind(to: releaseDateTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, releaseDate, cell in
                let country = self.viewModel.getCountryNameFrom(iso31661: releaseDate.iso31661)
                cell.textLabel?.setHeader(title: releaseDate.releaseDates.first?.releaseDate ?? "")
                cell.detailTextLabel?.setAttributeText(releaseDate.releaseDates.first?.certification ?? "")
                cell.imageView?.image = UIImage(named: "CountryFlags/\(country)")?.sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFit)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .releaseDates
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { releaseDates in
                self.emptyLabel.isHidden = !releaseDates.isEmpty
            })
            .disposed(by: rx.disposeBag)
    }
}
