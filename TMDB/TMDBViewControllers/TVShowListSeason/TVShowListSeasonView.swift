//
//  TVShowListSeasonView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class TVShowListSeasonView: UIViewController {
    
    var seasons: [Season] = []
    
    var tvShowId: Int?
    
    weak var delegate: ListSeasonViewDelegate?
    
    // MARK: - views
    @IBOutlet weak var seasonTableView: UITableView! {
        didSet {
            seasonTableView.register(UINib(nibName: String(describing: TMDBCustomTableViewCell.self), bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.tvShowSeasonCell)
            seasonTableView.tableFooterView = UIView()
            seasonTableView.rowHeight = 150
        }
    }
    
    init() {
        super.init(nibName: String(describing: TVShowListSeasonView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Season", comment: "")
        navigationItem.setBackArrowIcon()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.resetNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.resetNavBar()
    }
}

extension TVShowListSeasonView {
    func setupBinding() {
        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)
        
        // table view binding
        Observable<[Season]>
            .just(seasons)
            .bind(to: seasonTableView.rx.items(cellIdentifier: Constant.Identifier.tvShowSeasonCell)) { index, season, cell in
                (cell as? TMDBCustomTableViewCell)?.configure(item: season)
            }
            .disposed(by: rx.disposeBag)
        
        seasonTableView
            .rx
            .itemSelected
            .subscribe { event in
                guard
                    let indexPath = event.element,
                    let id = self.tvShowId
                else {
                    return
                }
                
                self.delegate?.navigateToSeasonDetail(season: self.seasons[indexPath.row], tvShowId: id)
            }
            .disposed(by: rx.disposeBag)
            
    }
}
