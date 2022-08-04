//
//  UINavigationController+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// pop from view controller with completion
    ///
    /// - Parameters:
    ///     - animated: need to animate or not
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        self.popViewController(animated: animated)
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
