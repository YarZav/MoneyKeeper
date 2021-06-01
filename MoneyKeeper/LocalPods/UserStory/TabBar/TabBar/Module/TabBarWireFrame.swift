//
//  TabBarWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Cash
import Swinject

final class TabBarWireFrameImp { }

// MARK: - TabBarWireFrame

extension TabBarWireFrameImp: TabBarWireFrame {

    func navigationController(for type: TabBarButtonType, rootViewController: UIViewController) -> UINavigationController {
//    let rootViewController = UIViewController()
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem.title = nil
    navigationController.tabBarItem.image = type.image
    return navigationController
  }
}
