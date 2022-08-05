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

  private let presenter: TabBarPresenter

  // MARK: - Init

  init(presenter: TabBarPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
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
