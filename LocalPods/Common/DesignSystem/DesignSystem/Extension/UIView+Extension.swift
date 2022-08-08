//
//  UIView+Extension.swift
//  DesignSystem
//
//  Created by Yaroslav Zavyalov on 8/8/22.
//

public extension UIView {

  /// Set corner radius
  ///
  /// - Parameters:
  ///     - corners: Corner position
  ///     - radius: Corner radius
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }

}
