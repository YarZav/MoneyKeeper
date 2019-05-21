//
//  UICollectionView+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Plain init for UICollectionView
    convenience init(cells: [AnyClass], dataSource: UICollectionViewDataSource? = nil, delegate: UICollectionViewDelegate? = nil, layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.init(frame: .zero, collectionViewLayout: layout)
        self.dataSource = dataSource
        self.delegate = delegate
        
        cells.forEach { cellClass in
            guard let casted = cellClass.self as? UICollectionViewCell.Type else { return }
            let reuseIdentifier = String(describing: casted.self)
            self.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    /// Get cell for UICollectionView by IndexPath
    func dequeueCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}
