//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {

  // Properties
  var presenter: TabBarPresenter!
  var rootViewController: UIViewController!

  // Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear(rootViewController: rootViewController)
  }
}

// MARK: - TabBarView

extension TabBarViewController: TabBarView {
  func tabBarControllers(_ controllers: [UINavigationController]) {
    viewControllers = controllers
  }
}

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    selectedViewController = viewController
  }
}
