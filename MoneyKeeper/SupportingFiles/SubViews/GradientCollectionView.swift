//
//  GradientCollectionView.swift
//  MoneyKeeper
//
//  Created by admin on 01.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - GradientCollectionView
class GradientCollectionView: UICollectionView {
    
    // Properties
    var topEndGradientPoint: NSNumber = NSNumber(value: 0.0)
    var bottomStartGradientPoint: NSNumber = NSNumber(value: 0.9)
    
    // Init
    init(cells: [AnyClass], dataSource: UICollectionViewDataSource? = nil, delegate: UICollectionViewDelegate? = nil) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.dataSource = dataSource
        self.delegate = delegate
        cells.forEach { cellClass in
            guard let casted = cellClass.self as? UICollectionViewCell.Type else { return }
            let reuseIdentifier = String(describing: casted.self)
            self.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateGradient()
    }
}

// MARK: - Publics
extension GradientCollectionView {
    
    public func setTopGradientPoint(_ scrollView: UIScrollView, defaultOffset: CGFloat = 20.0) {
        var topOffset: CGFloat = 0
        if scrollView.contentOffset.y <= 0 {
            topOffset = 0
        } else if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= defaultOffset {
            topOffset = scrollView.contentOffset.y
        } else {
            topOffset = defaultOffset
        }
        let topGradientOffset = Float((topOffset / defaultOffset) * 0.1)
        self.topEndGradientPoint = NSNumber(value: topGradientOffset)
    }
    
    public func setBottomGradientPoint(_ scrollView: UIScrollView, defaultOffset: CGFloat = 20.0) {
        var bottomOffset: CGFloat = 0
        if (scrollView.contentOffset.y + scrollView.bounds.size.height) >= scrollView.contentSize.height {
            bottomOffset = 0
        } else if (scrollView.contentOffset.y + scrollView.bounds.size.height) >= (scrollView.contentSize.height - defaultOffset) && (scrollView.contentOffset.y + scrollView.bounds.size.height) < scrollView.contentSize.height {
            bottomOffset = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height)
        } else {
            bottomOffset = defaultOffset
        }
        let bottomGradientOffset = Float(1 - (bottomOffset / defaultOffset) * 0.1)
        self.bottomStartGradientPoint = NSNumber(value: bottomGradientOffset)
    }
}

// MARK: - Prvates
extension GradientCollectionView {
    
    private func updateGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor(white: 1, alpha: 0).cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 0).cgColor
        ]
        gradient.locations = [0, self.topEndGradientPoint, self.bottomStartGradientPoint, 1]
        self.layer.mask = gradient
    }
}
