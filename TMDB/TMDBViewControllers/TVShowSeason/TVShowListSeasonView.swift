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
    
    var season: [Season] = []
    
    weak var delegate: ListSeasonViewDelegate?
    
    var userSetting: TMDBUserSettingProtocol
    
    // MARK: - views
    @IBOutlet weak var seasonTableView: UITableView! {
        didSet {
            seasonTableView.register(UINib(nibName: String(describing: TMDBCustomTableViewCell.self), bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.tvShowSeasonCell)
            seasonTableView.tableFooterView = UIView()
            seasonTableView.rowHeight = 211
        }
    }
    
    init(userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
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
            .just(season)
            .bind(to: seasonTableView.rx.items(cellIdentifier: Constant.Identifier.tvShowSeasonCell)) { index, season, cell in
                (cell as? TMDBCustomTableViewCell)?.configure(item: season)
                cell.layoutIfNeeded()
            }
            .disposed(by: rx.disposeBag)
            
    }
}
