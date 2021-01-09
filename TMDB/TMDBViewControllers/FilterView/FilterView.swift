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

protocol ApplyYearProtocol: class {
    var selectedYear: Int? { get }

    func apply(year: String?)
    func cancel()
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
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)

    @IBOutlet weak var filterTableView: UITableView! {
        didSet {
            filterTableView.tintColor = Constant.Color.primaryColor
            filterTableView.register(UINib(nibName: String(describing: SortByTableViewCell.self), bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.sortByCell)
            filterTableView.register(UINib(nibName: String(describing: GenreTableViewCell.self), bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.genreCell)
            filterTableView.register(UINib(nibName: "BasicDisclosureIndicatorTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.yearCell)
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

extension FilterView: ApplyYearProtocol {
    
    var selectedYear: Int? {
        return viewModel.applyFilterQuery.primaryReleaseYear
    }
    
    func apply(year: String?) {
        filterTableView.reloadSections(IndexSet(0...2), with: .none)
        filterTableView.cellForRow(at: IndexPath(row: 0, section: 3))?.detailTextLabel?.setHeader(title: year == nil ? "Any" : year!)
        viewModel.applyFilterQuery.primaryReleaseYear = year == nil ? nil : Int(year!)
        doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.applyFilterQuery
    }

    func cancel() {
        filterTableView.reloadSections(IndexSet(0...2), with: .none)
    }
}

extension FilterView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < 3 else {
            if indexPath.section == 3 {
                tableView.deselectRow(at: indexPath, animated: false)
                delegate?.navigateToYearView(applyYear: self)
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
            if selectedIndexPath.section < 3, selectedIndexPath != indexPath {
                tableView.cellForRow(at: selectedIndexPath)?.isSelected = false
                tableView.deselectRow(at: selectedIndexPath, animated: false)
            }
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard indexPath.section < 3 else {
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < 4 {
            return UITableView.automaticDimension
        }
        return 163
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.sortByCell, for: indexPath) as! SortByTableViewCell
            
            cell.setup(at: indexPath, tableView: tableView, filter: viewModel.applyFilterQuery)

            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.yearCell, for: indexPath)
            if let year = viewModel.applyFilterQuery.primaryReleaseYear {
                cell.detailTextLabel?.setHeader(title: String(year))
            } else {
                cell.detailTextLabel?.setHeader(title: "Any")
            }
            cell.textLabel?.setHeader(title: "Year")

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.genreCell, for: indexPath) as! GenreTableViewCell
        cell.setup(viewModel: viewModel, mediaType: .movie, selection: { genreId, isSelected in
            self.viewModel.handleGenre(id: genreId, isSelected: isSelected)
            self.doneBarButton.isEnabled = self.applyFilterDelegate?.query != self.viewModel.applyFilterQuery
        })
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popularity"
        } else if section == 1 {
            return "Rating Average"
        } else if section == 2 {
            return "Most Rate"
        }
        return "Genres"
    }
    
}
