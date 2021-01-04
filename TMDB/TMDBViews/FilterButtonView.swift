//
//  FilterButtonView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/28/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

@IBDesignable
class FilterButtonView: UIView {
    private(set) var movieButton: UIButton = UIButton()
    private(set) var tvShowButton: UIButton = UIButton()
    private(set) var peopleButton: UIButton = UIButton()
    
    fileprivate lazy var indicatorLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = Constant.Color.primaryColor.cgColor
        layer.borderWidth = 3
        layer.borderColor = Constant.Color.primaryColor.cgColor
        layer.frame = CGRect(x: 0, y: self.bounds.maxY - 3/2, width: 0, height: 3)
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        movieButton.layoutSubviews()
        tvShowButton.layoutSubviews()
        peopleButton.layoutSubviews()
    }
    
    func setup() {
        movieButton.setAttributedTitle(TMDBLabel.setHeader(title: NSLocalizedString("Movies", comment: "")), for: .normal)
        tvShowButton.setAttributedTitle(TMDBLabel.setHeader(title: NSLocalizedString("TVShows", comment: "")), for: .normal)
        peopleButton.setAttributedTitle(TMDBLabel.setHeader(title: NSLocalizedString("People", comment: "")), for: .normal)
        
        setButtonsConstraint()
        setBottomBorder()
        setBindingToIndicateSelectedButton()
    }
    
    fileprivate func setBindingToIndicateSelectedButton() {
        movieButton
            .rx
            .tap
            .subscribe { _ in
                
                self.indicatorLayer.removeFromSuperlayer()
                self.indicatorLayer.frame.size.width = self.movieButton.frame.width

                if !self.movieButton.isSelected {
                    self.movieButton.layer.addSublayer(self.indicatorLayer)
                }
                
                self.tvShowButton.isSelected = false
                self.peopleButton.isSelected = false
                self.movieButton.isSelected = !self.movieButton.isSelected
            }
            .disposed(by: rx.disposeBag)
        
        tvShowButton
            .rx
            .tap
            .subscribe { _ in
                self.indicatorLayer.removeFromSuperlayer()
                self.indicatorLayer.frame.size.width = self.tvShowButton.frame.width

                if !self.tvShowButton.isSelected {
                    self.tvShowButton.layer.addSublayer(self.indicatorLayer)
                }
                
                self.movieButton.isSelected = false
                self.peopleButton.isSelected = false
                self.tvShowButton.isSelected = !self.tvShowButton.isSelected
            }
            .disposed(by: rx.disposeBag)
        
        peopleButton
            .rx
            .tap
            .subscribe { _ in
                self.indicatorLayer.removeFromSuperlayer()
                self.indicatorLayer.frame.size.width = self.peopleButton.frame.width

                if !self.peopleButton.isSelected {
                    self.peopleButton.layer.addSublayer(self.indicatorLayer)
                }
                
                self.tvShowButton.isSelected = false
                self.movieButton.isSelected = false
                self.peopleButton.isSelected = !self.peopleButton.isSelected
            }
            .disposed(by: rx.disposeBag)
    }
    
    private func setBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: bounds.maxY, width: frame.width + 15, height: 0.5)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        layer.addSublayer(bottomLine)
    }
    
    fileprivate func setButtonsConstraint() {
        addSubview(movieButton)
        addSubview(tvShowButton)
        addSubview(peopleButton)
        
        movieButton.translatesAutoresizingMaskIntoConstraints = false
        tvShowButton.translatesAutoresizingMaskIntoConstraints = false
        peopleButton.translatesAutoresizingMaskIntoConstraints = false

        
        // vertical
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: ["v": movieButton])
        )
        
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: ["v": tvShowButton])
        )

        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: ["v": peopleButton])
        )
        
        setHorizontalConstraint()
    }
    
    fileprivate func setHorizontalConstraint() {
        // horizontal
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tvShowButton(width@1000)]-0-[movieButton(width@1000)]-0-[peopleButton(width@750)]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: ["width":  UIScreen.main.bounds.width/3], // divide 3 buttons with equal width
                                           views: [
                                                "tvShowButton": tvShowButton,
                                                "movieButton": movieButton,
                                                "peopleButton": peopleButton
                                           ])
        )
    }
}

@IBDesignable
class DiscoveryFilterButtonView: FilterButtonView {
    override func setBindingToIndicateSelectedButton() {
        movieButton
            .rx
            .tap
            .subscribe { _ in
                guard !self.movieButton.isSelected else {
                    return
                }

                self.indicatorLayer.removeFromSuperlayer()
                self.indicatorLayer.frame.size.width = self.movieButton.frame.width

                self.movieButton.layer.addSublayer(self.indicatorLayer)
                
                self.tvShowButton.isSelected = false
                self.movieButton.isSelected = true
            }
            .disposed(by: rx.disposeBag)
        
        tvShowButton
            .rx
            .tap
            .subscribe { _ in
                guard !self.tvShowButton.isSelected else {
                    return
                }

                self.indicatorLayer.removeFromSuperlayer()
                self.indicatorLayer.frame.size.width = self.tvShowButton.frame.width

                self.tvShowButton.layer.addSublayer(self.indicatorLayer)
                
                self.movieButton.isSelected = false
                self.tvShowButton.isSelected = true
            }
            .disposed(by: rx.disposeBag)
    }
    
    override func setHorizontalConstraint() {
        peopleButton.removeFromSuperview()
        // horizontal
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[movieButton(width@1000)]-0-[tvShowButton(width@750)]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: ["width":  UIScreen.main.bounds.width/2], // divide 3 buttons with equal width
                                           views: [
                                                "tvShowButton": tvShowButton,
                                                "movieButton": movieButton
                                           ])
        )
        
        movieButton.layoutIfNeeded()
        indicatorLayer.frame.size.width = self.movieButton.frame.width
        movieButton.layer.addSublayer(self.indicatorLayer)
        movieButton.isSelected = true
    }
    
    func select(at: Int) {
        if at == 0 {
            tvShowButton.sendActions(for: .touchUpInside)
        } else {
            movieButton.sendActions(for: .touchUpInside)
        }
    }
}
