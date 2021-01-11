//
//  FilterView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/6/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

protocol ApplyProtocol: class {
    var currentApplyQuery: DiscoverQuery { get }

    func apply(year: String?)
    func apply(keywords: String?)
}

class FilterView: UIViewController {
    
    var viewModel: FilterViewModelProtocol
    
    weak var applyFilterDelegate: ApplyFilterDelegate? {
        didSet {
            if let query = applyFilterDelegate?.query {
                viewModel.applyFilterQuery = query
            }
        }
    }

    weak var delegate: FilterViewDelegate?

    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: nil, action: nil)

    @IBOutlet weak var filterTableView: UITableView! {
        didSet {
            filterTableView.tintColor = Constant.Color.primaryColor
            filterTableView.register(UINib(nibName: String(describing: SortByTableViewCell.self), bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.sortByCell)
            filterTableView.register(UINib(nibName: String(describing: GenreTableViewCell.self), bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.genreCell)
            filterTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.cell)
            filterTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - init
    init(viewModel: FilterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FilterView.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    override func viewDidLoad() {
        navigationController?.resetNavBar()
        doneBarButton.tintColor = Constant.Color.backgroundColor
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        setupBinding()
    }
}

extension FilterView {
    func setupBinding() {
        cancelBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
        
        doneBarButton
            .rx
            .tap
            .filter { self.doneBarButton.isEnabled }
            .subscribe { _ in
                self.dismiss(animated: true) {
                    self.applyFilterDelegate?.applyFilter(query: self.viewModel.applyFilterQuery)
                }
            }
            .disposed(by: rx.disposeBag)
    }
}

extension FilterView: ApplyProtocol {
    
    var currentApplyQuery: DiscoverQuery {
        viewModel.applyFilterQuery
    }

    func apply(keywords: String?) {
        let detailTextLabel = filterTableView.cellForRow(at: IndexPath(row: 0, section: 4))?.detailTextLabel
         
        viewModel.applyFilterQuery.withKeyword = keywords
        doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.applyFilterQuery

        if let numberOfSelectedKeywords = keywords?.components(separatedBy: ",").count {
            detailTextLabel?.setHeader(title: String(numberOfSelectedKeywords))
        } else {
            detailTextLabel?.setHeader(title: NSLocalizedString("Any", comment: ""))
        }
        
        filterTableView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
    }
    
    func apply(year: String?) {
        let detailTextLabel = filterTableView.cellForRow(at: IndexPath(row: 0, section: 3))?.detailTextLabel

        viewModel.applyFilterQuery.primaryReleaseYear = year == nil ? nil : Int(year!)
        doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.applyFilterQuery

        detailTextLabel?.setHeader(title: year ?? NSLocalizedString("Any", comment: ""))
        filterTableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
    }
}

extension FilterView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < 3 else {
            tableView.deselectRow(at: indexPath, animated: false)
            if indexPath.section == 3 {
                delegate?.navigateToYearView(apply: self)
            } else if indexPath.section == 4 {
                delegate?.navigateToKeywordView(apply: self)
            }
            return
        }

        let cell = tableView.cellForRow(at: indexPath) as! SortByTableViewCell
        cell.isSelected = true

        viewModel.selectSortByAt(row: indexPath.row, section: indexPath.section)

        switch viewModel.applyFilterQuery.sortBy {
        case .popularity(_), .voteAverage(_), .voteCount(_), .none:
            doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.applyFilterQuery
        }
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        tableView.indexPathsForSelectedRows?.forEach { selectedIndexPath in
            if indexPath.section < 3, selectedIndexPath.section < 3, selectedIndexPath != indexPath {
                tableView.cellForRow(at: selectedIndexPath)?.isSelected = false
                tableView.deselectRow(at: selectedIndexPath, animated: false)
            }
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard indexPath.section < 3 else {
            tableView.cellForRow(at: indexPath)?.isSelected = false
            return
        }

        let cell = tableView.cellForRow(at: indexPath) as! SortByTableViewCell
        cell.isSelected = false
        
        viewModel.deselectSortByAt()
        
        switch viewModel.applyFilterQuery.sortBy {
        case .popularity(_), .voteAverage(_), .voteCount(_), .none:
            doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.applyFilterQuery
        }
    }
}

extension FilterView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 3 {
            return 2
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < 5 {
            return UITableView.automaticDimension
        }
        return applyFilterDelegate?.visibleRow == 0 ? 165 : 138
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.sortByCell, for: indexPath) as! SortByTableViewCell
            
            cell.setup(at: indexPath, tableView: tableView, filter: viewModel.applyFilterQuery)

            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell, for: indexPath)
            if let year = viewModel.applyFilterQuery.primaryReleaseYear {
                cell.detailTextLabel?.setHeader(title: String(year))
            } else {
                cell.detailTextLabel?.setHeader(title: NSLocalizedString("Any", comment: ""))
            }
            cell.textLabel?.setHeader(title: NSLocalizedString("Year", comment: ""))

            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell, for: indexPath)
            if let keywords = viewModel.applyFilterQuery.withKeyword {
                cell.detailTextLabel?.setHeader(title: String(keywords.components(separatedBy: ",").count))
            } else {
                cell.detailTextLabel?.setHeader(title: NSLocalizedString("Any", comment: ""))
            }
            cell.textLabel?.setHeader(title: NSLocalizedString("Keyword", comment: ""))

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.genreCell, for: indexPath) as! GenreTableViewCell
        let mediaType = applyFilterDelegate?.visibleRow == 0 ? GenreTableViewCell.MediaType.movie : GenreTableViewCell.MediaType.tvShow
        cell.setup(viewModel: viewModel, mediaType: mediaType, selection: { genreId, isSelected in
            self.viewModel.handleGenre(id: genreId, isSelected: isSelected)
            self.doneBarButton.isEnabled = self.applyFilterDelegate?.query != self.viewModel.applyFilterQuery
        })
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("Popularity", comment: "")
        } else if section == 1 {
            return NSLocalizedString("Rating Average", comment: "")
        } else if section == 2 {
            return NSLocalizedString("Most Rate", comment: "")
        } else if section == 5 {
            return NSLocalizedString("Genres", comment: "")
        }
        return ""
    }
    
}
