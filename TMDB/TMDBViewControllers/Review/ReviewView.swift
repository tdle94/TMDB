//
//  ReviewView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/1/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class ReviewView: UIViewController {
    
    var reviews: [Review] = []
    
    weak var delegate: CommonNavigation?
    
    @IBOutlet weak var reviewTableView: UITableView! {
        didSet {
            reviewTableView.register(UINib(nibName: "TitleWithSubtitleTableViewCell", bundle: nil),
                                     forCellReuseIdentifier: Constant.Identifier.cell)
            reviewTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setBackArrowIcon()
        title = NSLocalizedString("Review", comment: "")
        // left bar button item
        navigationItem
            .leftBarButtonItem?
            .rx
            .tap
            .subscribe { _ in
                self.delegate?.navigateBack()
            }
            .disposed(by: rx.disposeBag)
        
        Observable<[Review]>
            .just(reviews)
            .bind(to: reviewTableView.rx.items(cellIdentifier: Constant.Identifier.cell)) { index, review, cell in
                cell.textLabel?.setHeader(title: review.author)
                cell.detailTextLabel?.setAttributeText(review.content)
            }
            .disposed(by: rx.disposeBag)
        
        reviewTableView
            .rx
            .itemSelected
            .asDriver()
            .drive(onNext: { indexPath in
                guard let cell = self.reviewTableView.cellForRow(at: indexPath), cell.detailTextLabel?.numberOfLines != 0 else {
                    return
                }

                cell.detailTextLabel?.numberOfLines = 0
                self.reviewTableView.reloadData()
            })
            .disposed(by: rx.disposeBag)

    }
    
    init() {
        super.init(nibName: String(describing: ReviewView.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

