//
//  UIScrollView+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/11/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UITableView {
    var isAtBottom: Bool {
        return contentOffset.y >= (contentSize.height - frame.size.height)
    }
}

extension UICollectionView {
    var isAtBottom: Bool {
        return contentOffset.y + frame.size.height >= contentSize.height
    }
}

extension UIScrollView {
    
    func getCurrentAlpha(navigationController: UINavigationController?) -> CGFloat {
        let originalYOffset = self.parallaxHeader.originalYOffset
        let offset = self.contentOffset.y
        let navBarFromScrollViewOffset = safeAreaInsets.top + (navigationController?.navigationBar.frame.maxY ?? 0)
        let alpha = 1 - (abs(offset) - navBarFromScrollViewOffset) / (abs(originalYOffset) - navBarFromScrollViewOffset)
        
        return alpha
    }
    
    func setToPreviousAlpha(navigationController: UINavigationController?) {
        guard self.contentOffset.y < 0 else {
            setForegroundColor(alpha: 1, navigationController: navigationController)
            return
        }
        let alpha = getCurrentAlpha(navigationController: navigationController)
        setForegroundColor(alpha: alpha, navigationController: navigationController)
    }

    func setForegroundColor(alpha: CGFloat, navigationController: UINavigationController?) {
        let color = Constant.Color.primaryColor.withAlphaComponent(alpha)
        let image = UIImage.imageFromColor(color: color)
        
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor.withAlphaComponent(alpha)
        ]
    }
    
    func animateNavBar(safeAreaInsetTop: CGFloat, navigationController: UINavigationController?) {
        rx
            .didScroll
            .subscribe { _ in
                guard self.contentOffset.y < 0 else {
                    return
                }

                let originalYOffset = self.parallaxHeader.originalYOffset
                let offset = self.contentOffset.y
                let navBarFromScrollViewOffset = safeAreaInsetTop + (navigationController?.navigationBar.frame.maxY ?? 0)
                
                let alpha = 1 - (abs(offset) - navBarFromScrollViewOffset) / (abs(originalYOffset) - navBarFromScrollViewOffset)
                let color = Constant.Color.primaryColor.withAlphaComponent(alpha)
                let image = UIImage.imageFromColor(color: color)

                if abs(offset) >= navBarFromScrollViewOffset && offset > originalYOffset {
                    navigationController?.navigationBar.setBackgroundImage(image, for: .default)
                    navigationController?.navigationBar.shadowImage = image
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor.withAlphaComponent(alpha)
                    ]
                } else if offset <= originalYOffset {
                    navigationController?.navigationBar.setBackgroundImage(.imageFromColor(color: Constant.Color.primaryColor.withAlphaComponent(0)), for: .default)
                    navigationController?.navigationBar.shadowImage = .imageFromColor(color: Constant.Color.primaryColor.withAlphaComponent(0))
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor.withAlphaComponent(0)
                    ]
                }
        }.disposed(by: rx.disposeBag)
    }
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.parallaxHeader"
    }
    
    /**
     The parallax header.
     */
    public var parallaxHeader: ParallaxHeader {
        get {
            if let header = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? ParallaxHeader {
                return header
            }
            let header = ParallaxHeader()
            header.contentView.isSkeletonable = true
            self.parallaxHeader = header
            return header
        }
        set(parallaxHeader) {
            parallaxHeader.scrollView = self
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                parallaxHeader,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
