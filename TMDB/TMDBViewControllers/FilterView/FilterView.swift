//
//  FilterView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/6/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxDataSources

class FilterView: UIViewController {
    
    var viewModel: FilterViewModelProtocol
    
    weak var applyFilterDelegate: ApplyFilterDelegate? {
        didSet {
            viewModel.apply(query: applyFilterDelegate?.query)
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
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
        
        doneBarButton
            .rx
            .tap
            .filter { self.doneBarButton.isEnabled }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
                self.applyFilterDelegate?.applyFilter(query: self.viewModel.query)
            })
            .disposed(by: rx.disposeBag)
        
        viewModel
            .notifyUIChange
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { _ in
                let yearDetailTextLabel = self.filterTableView.cellForRow(at: IndexPath(row: 0, section: 3))?.detailTextLabel
                let keywordDetailTextLabel = self.filterTableView.cellForRow(at: IndexPath(row: 0, section: 4))?.detailTextLabel
                let countryDetailTextLabel = self.filterTableView.cellForRow(at: IndexPath(row: 0, section: 5))?.detailTextLabel
                let languageDetailTextLabel = self.filterTableView.cellForRow(at: IndexPath(row: 0, section: 6))?.detailTextLabel
    
                self.doneBarButton.isEnabled = self.applyFilterDelegate?.query != self.viewModel.query
                
                keywordDetailTextLabel?.setHeader(title: self.viewModel.selectedKeywordCount)

                yearDetailTextLabel?.setHeader(title: self.viewModel.selectedYear)

                countryDetailTextLabel?.setHeader(title: self.viewModel.selectedCountry)

                languageDetailTextLabel!.setHeader(title: self.viewModel.selectdLanguage)

                self.filterTableView.reloadSections(IndexSet(integersIn: 3...6), with: .automatic)
            })
            .disposed(by: rx.disposeBag)
    }
}

extension FilterView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < 3 else {
            tableView.deselectRow(at: indexPath, animated: false)
            if indexPath.section == 3 {
                delegate?.navigateToYearView(apply: viewModel)
            } else if indexPath.section == 4 {
                delegate?.navigateToKeywordView(apply: viewModel)
            } else if indexPath.section == 5 {
                delegate?.navigateToCountryView(apply: viewModel)
            } else if indexPath.section == 6 {
                delegate?.navigateToLanguageView(apply: viewModel)
            }
            return
        }

        let cell = tableView.cellForRow(at: indexPath) as! SortByTableViewCell
        cell.isSelected = true

        viewModel.selectSortByAt(row: indexPath.row, section: indexPath.section)

        switch viewModel.query?.sortBy {
        case .popularity(_), .voteAverage(_), .voteCount(_), .none?:
            doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.query
        case nil:
            break
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
        
        switch viewModel.query?.sortBy {
        case .popularity(_), .voteAverage(_), .voteCount(_), .none?:
            doneBarButton.isEnabled = applyFilterDelegate?.query != viewModel.query
        case nil:
            break
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < 7 {
            return UITableView.automaticDimension
        }
        return applyFilterDelegate?.visibleRow == 0 ? 165 : 138
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.sortByCell, for: indexPath) as! SortByTableViewCell
            
            cell.setup(at: indexPath, tableView: tableView, filter: viewModel.query)

            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell, for: indexPath)
            cell.detailTextLabel?.setHeader(title: viewModel.selectedYear)
            cell.textLabel?.setHeader(title: NSLocalizedString("Year", comment: ""))

            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell, for: indexPath)
            cell.detailTextLabel?.setHeader(title: viewModel.selectedKeywordCount)
            cell.textLabel?.setHeader(title: NSLocalizedString("Keyword", comment: ""))

            return cell
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell, for: indexPath)

            cell.detailTextLabel?.setHeader(title: viewModel.selectedCountry)
  
            cell.textLabel?.setHeader(title: NSLocalizedString("Country", comment: ""))
            
            return cell
        } else if indexPath.section == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cell, for: indexPath)

            cell.detailTextLabel?.setHeader(title: viewModel.selectdLanguage)

            cell.textLabel?.setHeader(title: NSLocalizedString("Language", comment: ""))
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.genreCell, for: indexPath) as! GenreTableViewCell
        let mediaType = applyFilterDelegate?.visibleRow == 0 ? GenreTableViewCell.MediaType.movie : GenreTableViewCell.MediaType.tvShow
        cell.setup(viewModel: viewModel, mediaType: mediaType, selection: { genreId, isSelected in
            self.viewModel.handleGenre(id: genreId, isSelected: isSelected)
            self.doneBarButton.isEnabled = self.applyFilterDelegate?.query != self.viewModel.query
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
        } else if section == 7 {
            return NSLocalizedString("Genres", comment: "")
        }
        return ""
    }
    
}
