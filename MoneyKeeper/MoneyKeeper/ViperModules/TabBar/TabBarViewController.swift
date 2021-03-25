//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarViewController
class TabBarViewController: UITabBarController {

  //Properties
  var presenter: TabBarPresenter!

  //Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

// MARK: - TabBarView
extension TabBarViewController: TabBarView {
  func tabBarControllers(_ controlelrs: [UIViewController]) {
    tabBar.unselectedItemTintColor = .black
    viewControllers = controlelrs
  }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    selectedViewController = viewController
  }
}
