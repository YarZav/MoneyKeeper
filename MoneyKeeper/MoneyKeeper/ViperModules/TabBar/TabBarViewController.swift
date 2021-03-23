//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarViewController
class TabBarViewController: BaseTabBarController {

  //Properties
  public var presenter: TabBarPresenterProtocol!
  public let navigationTypes: [TabBarButtonType] = [.cash, .cashFlowDetail, .cards, .goal, .settings]

  //Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.createTabBarControlelrs(for: self.navigationTypes)
  }
}

// MARK: - TabBarViewControllerProtocol
extension TabBarViewController: TabBarViewControllerProtocol {

  func createTabBarControllers(controlelrs: [UIViewController]) {
    tabBar.unselectedItemTintColor = .black
    self.viewControllers = controlelrs
  }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    self.selectedViewController = viewController
  }
}
