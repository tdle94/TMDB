//
//  LanguageView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/14/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class LanguageView: UIViewController {
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var viewModel: LanguageViewModelProtocol
    
    weak var applyDelegate: ApplyProtocol? {
        didSet {
            viewModel.query = applyDelegate?.applyFilterQuery
        }
    }
    
    // MARK: - init
    init(viewModel: LanguageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LanguageView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)

    @IBOutlet weak var languageTableView: UITableView! {
        didSet {
            languageTableView.register(UINib(nibName: String(describing: "SortByTableViewCell"), bundle: nil),
                                       forCellReuseIdentifier: Constant.Identifier.languageCell)
            languageTableView.tableFooterView = UIView()
            languageTableView.tintColor = Constant.Color.primaryColor
            languageTableView.allowsMultipleSelection = false
            languageTableView.delegate = self
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false

        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        navigationItem.setRightBarButton(doneBarButton, animated: true)

        searchController.setup(withPlaceholder: NSLocalizedString("Language", comment: ""))

        navigationItem.titleView = searchController.searchBar
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        languageTableView.scrollToRow(at: IndexPath(row: viewModel.selectedRow ?? 0, section: 0), at: .middle, animated: false)
    }
}

extension LanguageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == nil || tableView.indexPathForSelectedRow != indexPath {
            return indexPath
        }

        tableView.deselectRow(at: indexPath, animated: false)
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        viewModel.handleSelect(at: indexPath.row, isSelected: false)
        doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.applyFilterQuery
        return nil
    }
}

extension LanguageView {
    func setupBinding() {
        
        viewModel
            .languages
            .bind(to: languageTableView.rx.items(cellIdentifier: Constant.Identifier.languageCell)) { row, language, cell in
                if self.viewModel.selectedRow == row {
                    self.languageTableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                    cell.isSelected = true
                }
                cell.textLabel?.setHeader(title: language.name)
            }
            .disposed(by: rx.disposeBag)
        
        languageTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.languageTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.viewModel.handleSelect(at: indexPath.row, isSelected: true)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.applyFilterQuery
            })
            .disposed(by: rx.disposeBag)
        
        languageTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.languageTableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.viewModel.handleSelect(at: indexPath.row, isSelected: false)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.applyFilterQuery
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
                self.viewModel.search(language: query)
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
