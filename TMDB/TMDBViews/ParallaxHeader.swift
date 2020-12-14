//
//  ParallaxHeader.swift
//  ParallaxHeader
//
//  Created by Tuyen Le on 6/22/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import ObjectiveC.runtime


public typealias ParallaxHeaderHandlerBlock = (_ parallaxHeader: ParallaxHeader)->Void


private let parallaxHeaderKVOContext = UnsafeMutableRawPointer.allocate(
    byteCount: 4,
    alignment: 1
)

class ParallaxRefreshControl: UIRefreshControl {
    
    let attrs: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 235/255, green: 235/255, blue:  240/255, alpha: 1),
                                                 NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]

    override init() {
        super.init()
        tintColor = UIColor(displayP3Red: 235/255, green: 235/255, blue:  240/255, alpha: 1)
        attributedTitle = NSAttributedString(string: "release to update", attributes: attrs)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        attributedTitle = NSAttributedString(string: "release to update", attributes: attrs)
    }
    
    public override func beginRefreshing() {
        super.beginRefreshing()
        attributedTitle = NSAttributedString(string: "updating...", attributes: attrs)
    }
}

class ParallaxView: UIView {
    
    fileprivate weak var parent: ParallaxHeader!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let scrollView = self.superview as? UIScrollView else {
            return
        }
        scrollView.removeObserver(
            self.parent,
            forKeyPath: NSStringFromSelector(
                #selector(getter: scrollView.contentOffset)
            ),
            context: parallaxHeaderKVOContext
        )
    }

    override func didMoveToSuperview() {
        guard let scrollView = self.superview as? UIScrollView else {
            return
        }
        scrollView.addObserver(
            self.parent,
            forKeyPath: NSStringFromSelector(
                #selector(getter: scrollView.contentOffset)
            ),
            options: NSKeyValueObservingOptions.new,
            context: parallaxHeaderKVOContext
        )
    }
}


public class DotView: UIView {
    private let circle = CAShapeLayer()
    
    public let index: Int
    
    public var isSelected: Bool = false {
        didSet {
            if isSelected {
                circle.fillColor = UIColor.white.cgColor
                circle.strokeColor = UIColor.white.cgColor
            } else {
                circle.fillColor = UIColor.gray.cgColor
                circle.strokeColor = UIColor.gray.cgColor
            }
        }
    }
    
    public init(frame: CGRect, index: Int) {
        self.index = index
        super.init(frame: frame)
        
        circle.fillColor = UIColor.gray.cgColor
        circle.frame = CGRect(origin: .zero, size: frame.size)
        circle.path = UIBezierPath(arcCenter: CGPoint(x: bounds.minX, y: bounds.midY),
                                   radius: bounds.size.width/2,
                                   startAngle: 0,
                                   endAngle: .pi * 2,
                                   clockwise: true).cgPath
        circle.strokeColor = UIColor.gray.cgColor


        layer.addSublayer(circle)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CarouselView: UIView {
    
    public private(set) var currentSelectedDotIndex: Int = 0
    
    private var dotContainer: UIView = UIView()
    
    private var maxDots: [DotView] = []
    
    public private(set) var moveCnt: Int = 0
    
    private var maxMove: Int = 3
    
    public var distanceBetweenDot: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 32
        }
        return 16
    }
    
    let numberOfDot: Int
    
    public init(numberOfDot: Int) {
        self.numberOfDot = numberOfDot
        super.init(frame: .zero)
        dotContainer.backgroundColor = .clear
    }
    
    public override func layoutSubviews() {
        if numberOfDot == 1 || !dotContainer.subviews.isEmpty {
            return
        }

        addSubview(dotContainer)
        dotContainer.translatesAutoresizingMaskIntoConstraints = false
        dotContainer.widthAnchor.constraint(equalToConstant: distanceBetweenDot * 4).isActive = true
        dotContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0.0@250-[v]-0.0@250-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: ["v": dotContainer])
        )
        
        dotContainer.layoutIfNeeded()

        var distance: CGFloat = distanceBetweenDot/4
        
        for i in 0..<numberOfDot {
            var dimension: CGFloat = 8
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                dimension = 16
            }
            
            let dot = DotView(frame: CGRect(x: distance,
                                            y: dotContainer.frame.height / 2,
                                            width: dimension,
                                            height: dimension),
                              index: i)
            if i < maxMove {
                distance += distanceBetweenDot
            } else if i >= maxMove {
                dot.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
            }

            if maxDots.count <= maxMove {
                maxDots.append(dot)
            }
            
            dotContainer.addSubview(dot)
        }
        
        maxDots.first?.isSelected = true
    }
    
    public func selectDot(at index: Int) {
        guard index >= 0 && index < numberOfDot && abs(index - currentSelectedDotIndex) == 1 else {
            return
        }
        
        if index > currentSelectedDotIndex {
            
            moveCnt += 1

            if moveCnt == maxMove {
                
                let firstDotFrame = maxDots.first?.frame
            
                UIView.animate(withDuration: 0.5) {
                    self.maxDots.first?.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
                    self.maxDots.first?.frame.origin.x -= self.distanceBetweenDot
                }
                
                for i in 1..<maxDots.count {
                    maxDots[i - 1] = maxDots[i]
                }
                    
                if maxDots.last!.index + 1 < numberOfDot {
                    maxDots[maxDots.count - 1] = dotContainer.subviews[maxDots.last!.index + 1] as! DotView
                }

                UIView.animate(withDuration: 0.5) {
                    self.maxDots.first?.frame.origin.x = firstDotFrame?.origin.x ?? 0
                    self.maxDots[self.moveCnt - 1].transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }
               

                for i in 1..<maxDots.count-1 {
                    UIView.animate(withDuration: 0.5) {
                        self.maxDots[i].frame.origin.x = self.maxDots[i - 1].frame.maxX + self.distanceBetweenDot / 2
                    }
                }
                
                moveCnt -= 1
            }
            
            maxDots[moveCnt].isSelected = true
            maxDots[moveCnt - 1].isSelected = false
            
        } else {

            moveCnt -= 1
            
            if moveCnt == -1 {
                let firstDotFrame = maxDots.first?.frame
                
                moveCnt += 1
                
                for i in stride(from: maxDots.count - 1, to: 0, by: -1) {
                    maxDots[i] = maxDots[i - 1]
                }
                
                maxDots[0] = dotContainer.subviews[maxDots.first!.index - 1] as! DotView
                
                for i in 0..<maxDots.count-1 {
                    UIView.animate(withDuration: 0.5) {
                        self.maxDots[i].frame.origin.x = self.maxDots[i+1].frame.origin.x
                    }
                }
                
                UIView.animate(withDuration: 0.5) {
                    self.maxDots.last?.frame.origin.x += self.distanceBetweenDot
                    self.maxDots.last?.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
                    self.maxDots.first?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    self.maxDots.first?.frame.origin.x = firstDotFrame!.origin.x
                }

            }
            
            maxDots[moveCnt].isSelected = true
            maxDots[moveCnt + 1].isSelected = false
        }
        
        
        
        currentSelectedDotIndex = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



/**
 The ParallaxHeader class represents a parallax header for UIScrollView.
 */

public class ParallaxHeader: NSObject {
    
    //MARK: properties
    
    
    private weak var _scrollView: UIScrollView?
    var scrollView: UIScrollView! {
        get {
            return _scrollView
        }
        set(scrollView) {
            guard let scrollView = scrollView,
                scrollView != _scrollView else {
                    return
            }

            
            _scrollView = scrollView
            
            adjustScrollViewTopInset(
                top: scrollView.contentInset.top + height
            )
            scrollView.addSubview(contentView)
            
            layoutContentView()
        }
    }
    
    /**
     Carousel view
     */
    public var carouselView: CarouselView? {
        didSet {
            updateCaraouselView()
        }
    }
    
    /**
     Relative offset
     */
    public private(set) lazy  var originalYOffset: CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top - height
    
    /**
     Loading indicator
     */
    private var loadingIndicatorView: UIView = UIView()
    public private(set) var refreshControl: UIRefreshControl = ParallaxRefreshControl()
    
    /**
     The content view on top of the UIScrollView's content.
     */
    private var _contentView: UIView?
    var contentView: UIView {
        get {
            if let contentView = _contentView {
                return contentView
            }
            let contentView = ParallaxView()
            contentView.parent = self
            contentView.clipsToBounds = true

            _contentView = contentView
            return contentView
        }
    }
    
    /**
     The header's view.
     */
    private var _view: UIView?
    public var view: UIView {
        get {
            return _view!
        }
        set(view) {
            guard _view != view else {
                return
            }
            
            _view = view
            updateConstraints()
        }
    }
    
    /**
     The header's default height. 0 0 by default.
     */
    private var _height: CGFloat = 0
    public var height: CGFloat {
        get {
            return _height
        }
        set(height) {
            guard _height != height else {
                return
            }

            adjustScrollViewTopInset(top: height)
            
            _height = height
            
            updateConstraints()
            layoutContentView()
        }
    }
    
    /**
     The header's minimum height while scrolling up. 0 by default.
     */
    public var minimumHeight: CGFloat = 0 {
        didSet {
            layoutContentView()
        }
    }
    
    
    //MARK: constraints
    
    private func updateCaraouselView() {
        guard let carouselView = self.carouselView else {
            return
        }
        carouselView.removeFromSuperview()
        contentView.addSubview(carouselView)
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        setCarouselView()
    }
    
    private func updateConstraints() {
        view.removeFromSuperview()
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        loadingIndicatorView.removeFromSuperview()
        contentView.addSubview(loadingIndicatorView)
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingIndicatorView.addSubview(refreshControl)
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        
        setTopFillModeConstraints()
        setLoadingIndicator()
        setRefreshControl()
    }
    
    private func setCarouselView() {
        guard let carouselView = self.carouselView else {
            return
        }
        
        let binding = [
            "v": carouselView
        ]
        
        let metrics = [
            "lowPriority" : UILayoutPriority.defaultLow,
            "highPriority" : UILayoutPriority.defaultHigh,
            "height" : height - 50
            ] as [String : Any]
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: binding)
        )
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-height@lowPriority-[v]-0.0-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: metrics,
                                           views: binding)
        )
    }
    
    private func setLoadingIndicator() {
        let binding = [
            "v": loadingIndicatorView
        ]

        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: binding)
        )
        
        let metrics = [
            "lowPriority" : UILayoutPriority.defaultLow,
            "height" : height
            ] as [String : Any]

        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[v]-height@lowPriority-|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: metrics,
                                           views: binding)
        )
    }
    
    private func setRefreshControl() {
        let binding = [
            "v": refreshControl
        ]
        let metrics = [
            "height": loadingIndicatorView.frame.size.height
        ]

        loadingIndicatorView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: nil,
                                           views: binding)
        )
        
        loadingIndicatorView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[v(>=height)]|",
                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                           metrics: metrics,
                                           views: binding)
        )
    }
    
    private func setTopFillModeConstraints() {
        let binding = [
            "v" : view
        ]
        let metrics = [
            "highPriority" : UILayoutPriority.defaultHigh,
            "height" : height
            ] as [String : Any]
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: nil,
                views: binding
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[v(>=height)]-0.0@highPriority-|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: metrics,
                views: binding
            )
        )
    }
    
    //MARK: private
    
    private func layoutContentView() {
        guard let scrollView = scrollView else {
            return
        }
        let minimumHeight = min(self.minimumHeight, self.height)
        let relativeYOffset = scrollView.contentOffset.y + scrollView.contentInset.top - height

        let relativeHeight = -relativeYOffset

        let frame = CGRect(
            x: 0,
            y: relativeYOffset,
            width: scrollView.frame.size.width,
            height: max(relativeHeight, minimumHeight) - scrollView.safeAreaInsets.top
        )

        contentView.frame = frame
    }
    
    private func adjustScrollViewTopInset(top: CGFloat) {
        guard let scrollView = scrollView else {
            return
        }
        var inset = scrollView.contentInset
        
        //Adjust content offset
        var offset = scrollView.contentOffset
        offset.y += inset.top - top
        scrollView.contentOffset = offset

        //Adjust content inset
        inset.top = top
        scrollView.contentInset = inset
    }
    
    
    //MARK: KVO
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == parallaxHeaderKVOContext,
            let scrollView = scrollView else {
                super.observeValue(
                    forKeyPath: keyPath,
                    of: object,
                    change: change,
                    context: context
                )
                return
        }
        if keyPath == NSStringFromSelector(#selector(getter: scrollView.contentOffset)) {
            layoutContentView()
        }
    }
}
