//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {

  // MARK: - Private property

  private let presenter: TabBarPresenterProtocol

  // MARK: - Init

  init(presenter: TabBarPresenterProtocol) {
    self.presenter = presenter

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life circle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
  }

}

// MARK: - TabBarViewProtocol

extension TabBarViewController: TabBarViewProtocol {

  func tabBarControllers(_ viewControllers: [UINavigationController]) {
    self.viewControllers = viewControllers
  }

}

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    selectedViewController = viewController
  }

}
