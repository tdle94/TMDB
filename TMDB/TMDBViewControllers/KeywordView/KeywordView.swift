//
//  SearchKeywordView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/10/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

class KeywordView: UIViewController {
    var viewModel: KeywordViewModelProtocol
    
    weak var applyDelegate: ApplyProtocol? {
        didSet {
            viewModel.query = applyDelegate?.currentApplyQuery
        }
    }

    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    let addKeywordBarButton = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)

    @IBOutlet weak var keywordTableView: UITableView! {
        didSet {
            keywordTableView.tableFooterView = UIView()
            keywordTableView.delegate = self
            keywordTableView.register(UINib(nibName: "TitleWithSubtitleTableViewCell", bundle: nil),
                                      forCellReuseIdentifier: Constant.Identifier.keywordCell)
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
        navigationController?.resetNavBar()
        doneBarButton.tintColor = Constant.Color.backgroundColor
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        addKeywordBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false
        navigationItem.setRightBarButtonItems([addKeywordBarButton, doneBarButton], animated: true)
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        title = NSLocalizedString("Keyword", comment: "")
        setupBinding()
    }
}

extension KeywordView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        let numberOfKeywords = try! viewModel.keywords.value().count - 1

        guard numberOfKeywords != indexPath.row else {
            return nil
        }

        return indexPath
    }
}

extension KeywordView {
    func setupBinding() {
        doneBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.navigationController?.popViewController(animated: true)
                self.applyDelegate?.apply(keywords: self.viewModel.query?.withKeyword)
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
            .bind(to: keywordTableView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { row, keyword, cell in
                let keywords = self.viewModel.query?.withKeyword?.components(separatedBy: ",")

                if keywords?.contains(String(keyword.id)) ?? false {
                    self.keywordTableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                    cell.accessoryType = .checkmark
                } else {
                    self.keywordTableView.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
                    cell.accessoryType = .none
                }
                
                cell.isSelected = keywords?.contains(String(keyword.id)) ?? false
                cell.textLabel?.setHeader(title: keyword.name)
            }
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.keywordTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                let keywords = try! self.viewModel.keywords.value()
                self.viewModel.handle(keyword: keywords[indexPath.row], isSelected: true)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.currentApplyQuery
                
            })
            .disposed(by: rx.disposeBag)
        
        keywordTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.keywordTableView.cellForRow(at: indexPath)?.accessoryType = .none
                let keywords = try! self.viewModel.keywords.value()
                self.viewModel.handle(keyword: keywords[indexPath.row], isSelected: false)
                self.doneBarButton.isEnabled = self.viewModel.query != self.applyDelegate?.currentApplyQuery
            })
            .disposed(by: rx.disposeBag)
            
    }
}
