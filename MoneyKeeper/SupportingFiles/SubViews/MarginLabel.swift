////
////  MarginLabel.swift
////  MoneyKeeper
////
////  Created by Yaroslav Zavyalov on 20/02/2019.
////  Copyright © 2019 ZYG. All rights reserved.
////
//
//import UIKit
//
//// MARK: - MarginLabel
//class MarginLabel: UILabel {
//
//    /// Top inset
//    var topInset: CGFloat = 0.0
//    
//    /// Bottom inset
//    var bottomInset: CGFloat = 0.0
//    
//    /// Left inset
//    var leftInset: CGFloat = 16.0
//    
//    /// Right inset
//    var rightInset: CGFloat = 16.0
//    
//    // Overrides
//    public override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: rect.inset(by: insets))
//    }
//    
//    public override var intrinsicContentSize: CGSize {
//        let size = super.intrinsicContentSize
//        return CGSize(width: size.width + leftInset + rightInset,
//                      height: size.height + topInset + bottomInset)
//    }
//    
//    public override func sizeToFit() {
//        super.sizeThatFits(intrinsicContentSize)
//    }
//}
