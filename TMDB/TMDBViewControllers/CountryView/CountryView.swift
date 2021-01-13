//
//  CountryView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/12/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class CountryView: UIViewController {
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var viewModel: CountryViewModelProtocol
    
    weak var applyDelegate: ApplyProtocol? {
        didSet {
            viewModel.query = applyDelegate?.currentApplyQuery
        }
    }
    
    // MARK: - init
    init(viewModel: CountryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CountryView.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)

    @IBOutlet weak var countryTableView: UITableView! {
        didSet {
            countryTableView.register(UINib(nibName: String(describing: "SortByTableViewCell"), bundle: nil),
                                      forCellReuseIdentifier: Constant.Identifier.countryCell)
            countryTableView.tableFooterView = UIView()
            countryTableView.rowHeight = 60
            countryTableView.allowsMultipleSelection = false
            countryTableView.delegate = self
            countryTableView.tintColor = Constant.Color.primaryColor
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        doneBarButton.tintColor = Constant.Color.backgroundColor
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        
        definesPresentationContext = true

        doneBarButton.isEnabled = false
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        
        
        searchController.setup(withPlaceholder: NSLocalizedString("Country", comment: ""))
        
        navigationItem.titleView = searchController.searchBar

        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let row = viewModel.selectedRow {
            countryTableView.scrollToRow(at: IndexPath(row: Int(row), section: 0), at: .middle, animated: true)
        }
    }
}

extension CountryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == nil || tableView.indexPathForSelectedRow != indexPath {
            return indexPath
        }

        tableView.deselectRow(at: indexPath, animated: false)
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        viewModel.handleSelect(at: indexPath.row, isSelected: false)
        doneBarButton.isEnabled = true
        return nil
    }
}

extension CountryView {
    func setupBinding() {
        viewModel
            .countries
            .bind(to: countryTableView.rx.items(cellIdentifier: Constant.Identifier.countryCell)) { row, country, cell in
                if row == self.viewModel.selectedRow {
                    self.countryTableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                    cell.isSelected = true
                }
                cell.textLabel?.setHeader(title: country.name)
                cell.imageView?.image = UIImage(named: "CountryFlags/\(country.name)")?.sd_resizedImage(with: CGSize(width: 40, height: 40), scaleMode: .aspectFit)
            }
            .disposed(by: rx.disposeBag)
        
        countryTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.countryTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.viewModel.handleSelect(at: indexPath.row, isSelected: true)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.currentApplyQuery
            })
            .disposed(by: rx.disposeBag)
        
        countryTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.countryTableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.viewModel.handleSelect(at: indexPath.row, isSelected: false)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.currentApplyQuery
            })
            .disposed(by: rx.disposeBag)
        
        doneBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.applyDelegate?.apply(query: self.viewModel.query)
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        cancelBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        searchController
            .searchBar
            .rx
            .text
            .orEmpty
            .filter { !$0.isEmpty && !$0.trimmingCharacters(in: .whitespaces).isEmpty && !$0.last!.isWhitespace && !$0.first!.isWhitespace }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { query in
                self.viewModel.search(country: query)
            })
            .disposed(by: rx.disposeBag)
        
        searchController
            .searchBar
            .rx
            .cancelButtonClicked
            .asDriver().drive(onNext: {
                self.viewModel.resetSearch()
            })
            .disposed(by: rx.disposeBag)
    }
}
