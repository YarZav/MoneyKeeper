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
    convenience init(itemSize: CGSize, scrollDirection: UICollectionView.ScrollDirection = .horizontal, edgeInsets: UIEdgeInsets = .zero) {
        self.init()
        self.scrollDirection = scrollDirection
        self.sectionInset = edgeInsets
        self.itemSize = itemSize
    }
}
