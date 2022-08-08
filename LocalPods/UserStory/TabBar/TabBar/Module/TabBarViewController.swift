//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, TabBarProtocol {

  // MARK: - TabBarProtocol

  var cashViewController: UIViewController?

  // MARK: - Life circle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateUI()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tabBar.isTranslucent = false
    tabBar.barTintColor = .anthracite
  }

}

// MARK: - Private

private extension TabBarViewController {

  func updateUI() {
    viewControllers = [cashNavigationController]
  }

  var cashNavigationController: UINavigationController {
    guard let rootViewController = cashViewController else {
      fatalError("CashViewController is nil")
    }
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem.title = nil
    navigationController.tabBarItem.image = TabBarButtonType.cash.image
    return navigationController
  }

}

// MARK: - TabBarViewProtocol

extension TabBarViewController: TabBarViewProtocol { }

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    selectedViewController = viewController
  }

}
