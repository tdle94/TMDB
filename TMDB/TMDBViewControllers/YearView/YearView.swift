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
    var selectedIndexPath: IndexPath?

    var selectedYear: String?

    weak var applyYearDelegate: ApplyYearProtocol? {
        didSet {
            if
                let year = applyYearDelegate?.selectedYear,
                let row = years.firstIndex(of: String(year)) {
                
                selectedIndexPath = IndexPath(row: row, section: 0)
            }
        }
    }
    
    private var years: [String] = [
        "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963",
        "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977",
        "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991",
        "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005",
        "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019",
        "2020"
    ]

    // MARK: - views
    let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)

    @IBOutlet weak var yearTableView: UITableView! {
        didSet {
            yearTableView.register(UINib(nibName: "TitleWithSubtitleTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: Constant.Identifier.yearCell)
            yearTableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        navigationController?.resetNavBar()
        doneBarButton.tintColor = Constant.Color.backgroundColor
        cancelBarButton.tintColor = Constant.Color.backgroundColor
        doneBarButton.isEnabled = false
        navigationItem.setRightBarButton(doneBarButton, animated: true)
        navigationItem.setLeftBarButton(cancelBarButton, animated: true)
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let selectedIndexPath = self.selectedIndexPath {
            selectedYear = years[selectedIndexPath.row]
            yearTableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .middle)
        }
    }
}

extension YearView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPath = self.selectedIndexPath, indexPath == selectedIndexPath {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
            if self.applyYearDelegate?.selectedYear == Int(years[indexPath.row]) {
                doneBarButton.isEnabled = true
            }
            
            self.selectedIndexPath = nil
            return nil
        }
        return indexPath
    }
}

extension YearView {
    func setupBinding() {
        Observable<[String]>
            .just(years)
            .bind(to: yearTableView.rx.items(cellIdentifier: Constant.Identifier.yearCell)) { row, year, cell in
                if let selectedIndexPath = self.selectedIndexPath {
                    cell.accessoryType = row != selectedIndexPath.row ? .none : .checkmark
                }
                cell.textLabel?.setHeader(title: year)
            }
            .disposed(by: rx.disposeBag)
        
        yearTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                self.yearTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.doneBarButton.isEnabled = self.applyYearDelegate?.selectedYear != Int(self.years[indexPath.row])
                self.selectedIndexPath = indexPath
            })
            .disposed(by: rx.disposeBag)
            
        
        yearTableView
            .rx
            .itemDeselected
            .asDriver()
            .drive(onNext: { indexPath in
                self.yearTableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.doneBarButton.isEnabled = self.applyYearDelegate?.selectedYear != Int(self.years[indexPath.row])
                self.selectedIndexPath = nil
            })
            .disposed(by: rx.disposeBag)
        
        doneBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                if let indexPath = self.selectedIndexPath {
                    self.applyYearDelegate?.apply(year: self.years[indexPath.row])
                } else {
                    self.applyYearDelegate?.apply(year: nil)
                }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        cancelBarButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.applyYearDelegate?.cancel()
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: rx.disposeBag)
    }
}
