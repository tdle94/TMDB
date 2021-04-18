//
//  SearchKeywordView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/10/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class KeywordView: UIViewController {
    let searchController: UISearchController = UISearchController(searchResultsController: nil)

    var viewModel: KeywordViewModelProtocol
    
    weak var applyDelegate: ApplyProtocol? {
        didSet {
            viewModel.apply(query: applyDelegate?.query)
        }
    }

    // MARK: - views
    let notificationLabel = UILabel()
    let loadingIndicator = UIActivityIndicatorView(style: .medium)
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)

    @IBOutlet weak var keywordTableView: UITableView! {
        didSet {
            keywordTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            keywordTableView.tableFooterView?.addSubview(loadingIndicator)

            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            loadingIndicator.color = .black
            loadingIndicator.widthAnchor.constraint(equalTo: keywordTableView.tableFooterView!.widthAnchor).isActive = true
            loadingIndicator.heightAnchor.constraint(equalTo: keywordTableView.tableFooterView!.heightAnchor).isActive = true
            loadingIndicator.centerXAnchor.constraint(equalTo: keywordTableView.tableFooterView!.centerXAnchor).isActive = true
            loadingIndicator.centerYAnchor.constraint(equalTo: keywordTableView.tableFooterView!.centerYAnchor).isActive = true

            notificationLabel.textAlignment = .center
            notificationLabel.isHidden = true
            keywordTableView.backgroundView = notificationLabel
            keywordTableView.tintColor = Constant.Color.primaryColor
            keywordTableView.register(UINib(nibName: "TitleWithSubtitleTableViewCell", bundle: nil),
                                      forCellReuseIdentifier: Constant.Identifier.cell)
        }
    }
    
    // MARK: - init
    init(viewModel: KeywordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: KeywordView.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - overrides
    
    override func viewDidLoad() {
        doneBarButton.tintColor = Constant.Color.backgroundColor
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false
        
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        
        searchController.setup(withPlaceholder: NSLocalizedString("Keyword", comment: ""))
        
        navigationItem.titleView = searchController.searchBar

        setupBinding()
    }
}

extension KeywordView {
    func setupBinding() {
        viewModel
            .hideErrorLabel
            .bind(to: notificationLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .errorLabel
            .bind(to: notificationLabel.rx.attributedText)
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

        viewModel
            .keywords
            .bind(to: keywordTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { row, keyword, cell in
                let isSelected = self.viewModel.isThere(keyword: keyword, at: row)

                if isSelected {
                    self.keywordTableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                    cell.accessoryType = .checkmark
                } else {
                    self.keywordTableView.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
                    cell.accessoryType = .none
                }
                
                cell.isSelected = isSelected
                cell.textLabel?.setHeader(title: keyword.name)
            }
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
                self.notificationLabel.isHidden = true
                self.viewModel.searchKeyword(query: query, nextPage: false)
            })
            .disposed(by: rx.disposeBag)
        
        searchController
            .searchBar
            .rx
            .cancelButtonClicked
            .asDriver()
            .drive(onNext: {
                self.viewModel.resetSearch()
            })
            .disposed(by: rx.disposeBag)
        
        viewModel
            .isLoading
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.keywordTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.viewModel.handleKeyword(at: indexPath.row, isSelected: true)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.query
                
            })
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.keywordTableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.viewModel.handleKeyword(at: indexPath.row, isSelected: false)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.query
            })
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .didScroll
            .asDriver()
            .drive(onNext: {
                if self.searchController.searchBar.isFirstResponder {
                    self.searchController.searchBar.resignFirstResponder()
                }

                if let text = self.searchController.searchBar.text, self.keywordTableView.isAtBottom, text.isNotEmpty {
                    self.viewModel.searchKeyword(query: text, nextPage: true)
                }
            })
            .disposed(by: rx.disposeBag)
            
    }
}
