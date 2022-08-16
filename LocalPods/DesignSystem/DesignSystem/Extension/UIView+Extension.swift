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
    let path = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }

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
