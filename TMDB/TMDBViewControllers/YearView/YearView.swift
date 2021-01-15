//
//  YearView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/8/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class YearView: UIViewController {
    
    var viewModel: YearViewModel

    weak var applyDelegate: ApplyProtocol? {
        didSet {
            viewModel.apply(query: applyDelegate?.query)
        }
    }

    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)

    @IBOutlet weak var yearTableView: UITableView! {
        didSet {
            yearTableView.register(UINib(nibName: "TitleWithSubtitleTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: Constant.Identifier.cell)
            yearTableView.delegate = self
            yearTableView.tintColor = Constant.Color.primaryColor
        }
    }
    
    // MARK: - init
    init(viewModel: YearViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: YearView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - overrides
    override func viewDidLoad() {
        doneBarButton.tintColor = Constant.Color.backgroundColor
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false
        title = NSLocalizedString("Year", comment: "")
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        yearTableView.selectRow(at: IndexPath(row: viewModel.selectedRow ?? 0, section: 0), animated: true, scrollPosition: .middle)
    }
}

extension YearView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRow = viewModel.selectedRow, indexPath.row == selectedRow {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            viewModel.handleSelect(at: indexPath.row, isSelected: false)
            doneBarButton.isEnabled = applyDelegate?.query != viewModel.query
            return nil
        }
        return indexPath
    }
}

extension YearView {
    func setupBinding() {
        Observable<[String]>
            .just(viewModel.years)
            .bind(to: yearTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { row, year, cell in
                cell.accessoryType = row != self.viewModel.selectedRow ? .none : .checkmark
                cell.textLabel?.setHeader(title: year)
            }
            .disposed(by: rx.disposeBag)
        
        yearTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.yearTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.viewModel.handleSelect(at: indexPath.row, isSelected: true)
                self.doneBarButton.isEnabled = self.applyDelegate?.query != self.viewModel.query
            })
            .disposed(by: rx.disposeBag)
            
        
        yearTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.yearTableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.viewModel.handleSelect(at: indexPath.row, isSelected: false)
                self.doneBarButton.isEnabled = self.applyDelegate?.query != self.viewModel.query
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
    }
}
