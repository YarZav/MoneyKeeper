//
//  GradientScrollView.swift
//  MoneyKeeper
//
//  Created by admin on 01.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public extension UIScrollView {

  func getTopGradientPoint(_ scrollView: UIScrollView, defaultOffset: CGFloat = 20.0) -> NSNumber {
    var topOffset: CGFloat = 0
    if scrollView.contentOffset.y <= 0 {
      topOffset = 0
    } else if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= defaultOffset {
      topOffset = scrollView.contentOffset.y
    } else {
      topOffset = defaultOffset
    }
    let topGradientOffset = Float((topOffset / defaultOffset) * 0.1)
    return NSNumber(value: topGradientOffset)
  }

  func getBottomGradientPoint(_ scrollView: UIScrollView, defaultOffset: CGFloat = 20.0) -> NSNumber {
    let contentSize = scrollView.contentOffset.y + scrollView.bounds.size.height
    var bottomOffset: CGFloat = 0
    if contentSize >= scrollView.contentSize.height {
      bottomOffset = 0
    } else if contentSize >= (scrollView.contentSize.height - defaultOffset) && contentSize < scrollView.contentSize.height {
      bottomOffset = scrollView.contentSize.height - contentSize
    } else {
      bottomOffset = defaultOffset
    }
    let bottomGradientOffset = Float(1 - (bottomOffset / defaultOffset) * 0.1)
    return NSNumber(value: bottomGradientOffset)
  }

}
