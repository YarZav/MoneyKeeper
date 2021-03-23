//
//  TabBarWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarWireFrame
class TabBarWireFrame: BaseWireFrame { }

// MARK: - Prviates
extension TabBarWireFrame {

  private func getRootViewController(by type: TabBarButtonType) -> UIViewController {
    switch type {
    case .cash:           return self.resolver.cashViewCotnroller()
    case .cashFlowDetail: return self.resolver.cashFlowDetailViewCotnroller()
    case .cards:          return self.resolver.cardsViewCotnroller()
    case .goal:           return BaseViewController()
    case .settings:       return self.resolver.settingsViewCotnroller()
    }
  }
  
  private func customizeNavigationController(_ navigationController: UINavigationController, type: TabBarButtonType) {
    switch type {
    case .cash, .cards:
      navigationController.navigationBar.transparentNavigationBar(textColor: .white)

    case .cashFlowDetail:
      navigationController.navigationBar.barTintColor = .anthracite
      navigationController.navigationBar.opaque()
      navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    case .goal:
      break

    case .settings:
      navigationController.navigationBar.barTintColor = .lightBlue
      navigationController.navigationBar.opaque()
      navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
  }
}

// MARK: - TabBarWireFrameProtocol
extension TabBarWireFrame: TabBarWireFrameProtocol {

  func getNavigationController(by type: TabBarButtonType) -> UINavigationController {
    let rootViewController = self.getRootViewController(by: type)
    let navigationController = BaseNavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem = UITabBarItem(title: nil, image: type.image, selectedImage: type.selectedImage)
    customizeNavigationController(navigationController, type: type)
    return navigationController
  }
}
