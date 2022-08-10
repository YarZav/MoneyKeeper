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
  var cashDetailViewController: UIViewController?

  // MARK: - Life circle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateUI()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tabBar.barTintColor = .anthracite
    tabBar.tintColor = .white
  }

}

// MARK: - Private

private extension TabBarViewController {

  func updateUI() {
    viewControllers = [cashNavigationController, cashDetailNavigationController]
  }

  var cashNavigationController: UINavigationController {
    guard let rootViewController = cashViewController else {
      fatalError("CashViewController is nil")
    }
    let image = TabBarButtonType.cash.image
    let selectedImage = TabBarButtonType.cash.selectedImage
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
    return navigationController
  }

  var cashDetailNavigationController: UINavigationController {
    guard let rootViewController = cashDetailViewController else {
      fatalError("CashViewController is nil")
    }
    let image = TabBarButtonType.cashDetail.image
    let selectedImage = TabBarButtonType.cashDetail.selectedImage
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
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
