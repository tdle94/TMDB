//
//  ReleaseDateView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/31/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class ReleaseDateView: UIViewController {
    var movieId: Int?
    
    var viewModel: ReleaseDateViewModelProtocol
    
    weak var delegate: CommonNavigation?
    
    // MARK: - views
    @IBOutlet weak var releaseDateTableView: UITableView! {
        didSet {
            releaseDateTableView.rowHeight = 80
            releaseDateTableView.register(UINib(nibName: "TMDBCustomTableViewCell", bundle: nil), forCellReuseIdentifier: Constant.Identifier.releaseDateCell)
        }
    }
    
    // MARK:  - init
    init(viewModel: ReleaseDateViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ReleaseDateView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        title = NSLocalizedString("Release Date", comment: "")
        if let id = movieId {
            viewModel.getReleaseDates(movieId: id)
        }
    }
}

extension ReleaseDateView {
    func setupBinding() {
        navigationController?.resetNavBar()
        navigationItem.setBackArrowIcon()

        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)

        viewModel
            .releaseDates
            .bind(to: releaseDateTableView.rx.items(cellIdentifier: Constant.Identifier.releaseDateCell)) { index, releaseDate, cell in
                (cell as? TMDBCustomTableViewCell)?.configure(item: releaseDate)
            }
            .disposed(by: rx.disposeBag)
    }
}
