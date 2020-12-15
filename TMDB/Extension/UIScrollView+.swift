//
//  UIScrollView+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/11/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UIScrollView {
    func animateNavBar(safeAreaInsetTop: CGFloat, navigationController: UINavigationController?) {
        rx.didScroll.subscribe { _ in
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
            } else if offset <= originalYOffset && alpha >= 0.0 {
                navigationController?.navigationBar.setBackgroundImage(.init(), for: .default)
                navigationController?.navigationBar.shadowImage = .init()
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor.withAlphaComponent(0)
                ]
            } else if abs(offset) < navBarFromScrollViewOffset && alpha <= 1.0 {
                navigationController?.navigationBar.setBackgroundImage(.imageFromColor(color: color.withAlphaComponent(1)), for: .default)
                navigationController?.navigationBar.shadowImage = UIImage.imageFromColor(color: Constant.Color.primaryColor.withAlphaComponent(1))
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor.withAlphaComponent(1)
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
