//
//  TabBarWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

class TabBarWireFrameImp { }

// MARK: - TabBarWireFrame
extension TabBarWireFrameImp: TabBarWireFrame {

  func navigationController(for type: TabBarButtonType) -> UINavigationController {
    let rootViewController = UIViewController()
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem.title = nil
    navigationController.tabBarItem.image = type.image
    return navigationController
  }
}
