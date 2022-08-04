//
//  UIView+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 05.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

public extension UIView {

  /// DropShadow - Бросает тень на вьюшку, необходимые поля - ширина и высота тени
  ///
  /// - Parameters:
  ///     - width: ширина тени
  ///     - height: высота тени
  ///     - shadowColor: цвет тени (по умолчанию черный)
  ///     - shadowOffset: отступ тени от родительской вьюшки (по умолчанию width: 0.5, height: 5)
  ///     - shadowOpacity: помутнение тени (по умолчанию 0.5)
  ///     - shadowRadius: радиус тени (по умолчанию 5)
  func dropShadow(
    width: CGFloat,
    height: CGFloat,
    shadowColor: UIColor = .black,
    shadowOffset: CGSize = CGSize(width: 0.5, height: 5),
    shadowOpacity: Float = 0.5,
    shadowRadius: CGFloat = 5
  ) {
    let radius: CGFloat = width / 2.0
    let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2 * radius, height: height))
    
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOffset = shadowOffset
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = shadowRadius
    layer.masksToBounds = false
    layer.shadowPath = shadowPath.cgPath
  }
  
  /// Make view
  ///
  /// - Parameters:
  ///     - backgroundColor: background color
  convenience init(backgroundColor: UIColor) {
    self.init()
    self.backgroundColor = backgroundColor
  }
  
  /// Make corner radius
  ///
  /// - Parameters:
  ///     - radius: corner radius
  ///     - color: background color
  func cornerRadius(_ radius: CGFloat, color: UIColor?) {
    layer.masksToBounds = true
    layer.cornerRadius = radius
    backgroundColor = color
  }

}
