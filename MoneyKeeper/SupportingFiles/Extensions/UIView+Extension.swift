//
//  UIView+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 05.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - UIView extension
extension UIView {
    
    ///
    /// dropShadow - Бросает тень на вьюшку, необходимые поля - ширина и высота тени
    ///
    /// - Parameters:
    ///     - width: ширина тени
    ///     - height: высота тени
    ///     - shadowColor: цвет тени (по умолчанию черный)
    ///     - shadowOffset: отступ тени от родительской вьюшки (по умолчанию width: 0.5, height: 5)
    ///     - shadowOpacity: помутнение тени (по умолчанию 0.5)
    ///     - shadowRadius: радиус тени (по умолчанию 5)
    ///
    func dropShadow(width: CGFloat,
                    height: CGFloat,
                    shadowColor: UIColor = .black,
                    shadowOffset: CGSize = CGSize(width: 0.5, height: 5),
                    shadowOpacity: Float = 0.5,
                    shadowRadius: CGFloat = 5) {
        
        let radius: CGFloat = width / 2.0
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2 * radius, height: height))
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
    }
}
