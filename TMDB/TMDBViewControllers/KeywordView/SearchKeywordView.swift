//
//  SearchKeywordView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/11/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class SearchKeywordView: UIViewController {
    weak var applyKeywordDelegate: ApplyKeyword?

    let searchController: UISearchController
    
    let viewModel: SearchKeywordViewModelProtocol

    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    let notificationLabel = UILabel()

    @IBOutlet weak var keywordTableView: UITableView! {
        didSet {
            keywordTableView.tableFooterView = UIView()
            notificationLabel.textAlignment = .center
            notificationLabel.isHidden = true
            keywordTableView.backgroundView = notificationLabel
            keywordTableView.tintColor = Constant.Color.primaryColor
            keywordTableView.register(UINib(nibName: "SortByTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    
    // MARK: - init
    init(searchController: UISearchController, viewModel: SearchKeywordViewModelProtocol) {
        self.searchController = searchController
        self.viewModel = viewModel
        super.init(nibName: String(describing: SearchKeywordView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    override func viewDidLoad() {
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false
        
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        
        searchController.setup(withPlaceholder: NSLocalizedString("Keyword", comment: ""))
        
        navigationItem.titleView = searchController.searchBar

        setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}

extension SearchKeywordView {
    func setupBinding() {
        cancelBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        doneBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.applyKeywordDelegate?.apply(newKeywords: self.viewModel.selectedKeywords)
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)

        searchController
            .searchBar
            .rx
            .text
            .orEmpty
            .throttle(.seconds(1), latest: true, scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty && !$0.trimmingCharacters(in: .whitespaces).isEmpty && !$0.last!.isWhitespace && !$0.first!.isWhitespace }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { query in
                self.viewModel.searchKeyword(query: query, nextPage: false)
            })
            .disposed(by: rx.disposeBag)
        
        viewModel
            .keywords
            .filterNil()
            .bind(to: keywordTableView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { _, keyword, cell in
                cell.textLabel?.setHeader(title: keyword.name)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel
            .keywords
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { result in
                if result?.isEmpty ?? false {
                    self.notificationLabel.isHidden = false
                    self.notificationLabel.setHeader(title: NSLocalizedString("No keywords found", comment: ""))
                } else if result == nil {
                    self.notificationLabel.isHidden = false
                    self.notificationLabel.setHeader(title: NSLocalizedString("Error getting keyword", comment: ""))
                }
            })
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.doneBarButton.isEnabled = true
                self.keywordTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.viewModel.handleKeyword(at: indexPath.row, isSelected: true)
            })
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.doneBarButton.isEnabled = self.keywordTableView.indexPathsForSelectedRows?.isNotEmpty ?? false
                self.keywordTableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.viewModel.handleKeyword(at: indexPath.row, isSelected: false)
            })
            .disposed(by: rx.disposeBag)
    }
}
