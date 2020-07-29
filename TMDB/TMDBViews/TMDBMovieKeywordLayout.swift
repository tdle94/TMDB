//
//  TMDBMovieKeywordLayout.swift
//  TMDB
//
//  Created by Tuyen Le on 05.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBKeywordLayoutDelegate: AnyObject {
    func tagCellLayoutSize(layout: TMDBKeywordLayout, at index: Int) -> CGSize
}

class TMDBKeywordLayout: UICollectionViewLayout {
    
    var layouts: [UICollectionViewLayoutAttributes] = []
    
    var numberOfLine: Int = 0
    
    weak var delegate: TMDBKeywordLayoutDelegate?
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 18,
                      height: (CGFloat(numberOfLine) * (layouts.first?.frame.height ?? 0) + CGFloat(numberOfLine * 5) + CGFloat(layouts.first?.frame.height ?? 0) + 1 ))
    }
    
    init(delegate: TMDBKeywordLayoutDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepare() {
        layoutSetup()
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layouts[indexPath.row]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layouts
    }
}

extension TMDBKeywordLayout {
    var numberOfCell: Int {
        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }

    func layoutSetup() {
        numberOfLine = 0
        layouts.removeAll()
        (0 ..< numberOfCell).forEach { index in
            // get size and instantiate inital layout
            creatLayoutAttribute(at: index)
            // determine position (x,y)
            configureLayout(at: index)
        }
    }
    
    func creatLayoutAttribute(at index: Int) {
        guard let size = delegate?.tagCellLayoutSize(layout: self, at: index) else { return }
        let layout = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: index, section: 0))
        layout.size = size
        layouts.append(layout)
    }
    
    func configureLayout(at index: Int) {
        let currentLayout = layouts[index]
        let lastLayout = index == 0 ? layouts[0] : layouts[index - 1]
        let itemWidth = currentLayout.bounds.size.width

        if shouldMoveItemToNextRow(itemWidth: itemWidth, at: index) {
            let yPos = lastLayout.frame.maxY
            currentLayout.frame.origin = CGPoint(x: 18.0, y: yPos + 5)
            numberOfLine += 1
        } else {
            if layouts.count == 1 {
                let xPos = 18
                let yPos = 1
                currentLayout.frame.origin = CGPoint(x: xPos, y: yPos)
            } else {
                let xPos = lastLayout.frame.maxX + 5
                let yPos = lastLayout.frame.minY
                currentLayout.frame.origin = CGPoint(x: xPos, y: yPos)
            }
            
        }
    }
    
    func shouldMoveItemToNextRow(itemWidth: CGFloat, at index: Int) -> Bool {
        let lastLayout = index == 0 ? layouts[0] : layouts[index - 1]
        let currentItemFrame = lastLayout.frame
        return (currentItemFrame.maxX + itemWidth) + 18 > collectionView?.frame.maxX ?? 0
    }
}
