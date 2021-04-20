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
    
    let attrs: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor,
                                                 NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]

    override init() {
        super.init()
        tintColor = Constant.Color.backgroundColor
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
    
    private var pageControl: UIPageControl?
    public var dots: Int = 0 {
        didSet {
            pageControl?.removeFromSuperview()
            pageControl = nil
            pageControl = UIPageControl()
            pageControl?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            pageControl?.numberOfPages = dots
            pageControl?.currentPage = 0
            pageControl?.hidesForSinglePage = true
            updatePageControl()
        }
    }
    
    
    /**
     Relative offset
     */
    var originalYOffset: CGFloat {
        return -scrollView.adjustedContentInset.top
    }
    
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
            _view?.backgroundColor = .black
            _view = view
            height = ceil(UIScreen.main.bounds.height / 2.5)
            minimumHeight = 0
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
    
    public func selectDot(at: Int) {
        pageControl?.currentPage = at
    }
    
    private func updatePageControl() {
        guard let page = self.pageControl else {
            return
        }
        page.removeFromSuperview()
        contentView.addSubview(page)
        page.translatesAutoresizingMaskIntoConstraints = false
        setPageControl()
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
    
    private func setPageControl() {
        guard let page = self.pageControl else {
            return
        }

        let binding = [
            "v": page
        ]
        
        let metrics = [
            "lowPriority" : UILayoutPriority.defaultLow,
            "highPriority" : UILayoutPriority.defaultHigh,
            "height" : height - 25
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
            "height" : height - 44
            ] as [String : Any]

        contentView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-44-[v]-height@lowPriority-|",
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
            height: max(relativeHeight, minimumHeight) - 94
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
