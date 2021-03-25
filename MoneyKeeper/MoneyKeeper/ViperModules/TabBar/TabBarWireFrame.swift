//
//  TabBarWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

class TabBarWireFrameImp { }

// MARK: - Prviates
extension TabBarWireFrameImp {

  private func getRootViewController(by type: TabBarButtonType) -> UIViewController {
//    switch type {
//    case .cash:           return resolver.cashViewCotnroller()
//    case .cashFlowDetail: return resolver.cashFlowDetailViewCotnroller()
//    case .cards:          return resolver.cardsViewCotnroller()
//    case .goal:           return BaseViewController()
//    }
    return UIViewController()
  }
  
  private func customizeNavigationController(_ navigationController: UINavigationController, type: TabBarButtonType) {
    switch type {
    case .cash, .cards:
      navigationController.navigationBar.transparentNavigationBar(textColor: .white)

    case .cashDetail:
      navigationController.navigationBar.barTintColor = .anthracite
      navigationController.navigationBar.opaque()
      navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    case .goal:
      break
    }
  }
}

// MARK: - TabBarWireFrame
extension TabBarWireFrameImp: TabBarWireFrame {

  func getNavigationController(by type: TabBarButtonType) -> UINavigationController {
    let rootViewController = self.getRootViewController(by: type)
    let navigationController = BaseNavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem = UITabBarItem(title: nil, image: type.image, selectedImage: type.selectedImage)
    customizeNavigationController(navigationController, type: type)
    return navigationController
  }
}
