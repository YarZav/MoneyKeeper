//
//  LaunchWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - LaunchWireFrame
class LaunchWireFrame: BaseWireFrame { }

// MARK: - LaunchWireFrameProtocol
extension LaunchWireFrame: LaunchWireFrameProtocol {
    
    func presentTabbarController() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = self.resolver.createTabBarViewCotnroller()
    }
}
