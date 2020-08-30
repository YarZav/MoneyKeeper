//
//  UICollectionViewFlowLayout+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    /// Plain init for UICollactionFlowLayout
    ///
    /// - Parameters:
    ///     - itemSize: size of cell
    ///     - scrollDirection: scroll for collection view
    ///     - edgeInsets: sitem insets
    convenience init(itemSize: CGSize, scrollDirection: UICollectionView.ScrollDirection = .horizontal, edgeInsets: UIEdgeInsets = .zero) {
        self.init()
        self.scrollDirection = scrollDirection
        self.sectionInset = edgeInsets
        self.itemSize = itemSize
    }
}
