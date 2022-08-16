//
//  TabBarViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import DesignSystem

final class TabBarViewController: UITabBarController, TabBarProtocol, TabBarViewProtocol {

  // MARK: - TabBarProtocol

  var cashViewController: UIViewController?
  var cashDetailViewController: UIViewController?

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateUI()
  }

}

// MARK: - Private

private extension TabBarViewController {

  func createUI() {
    tabBar.barTintColor = .anthracite
    tabBar.tintColor = .white
  }

  func updateUI() {
    let cashNavigationController = navigationController(with: cashViewController, type: .cash)
    let cashDetailNavigationController = navigationController(with: cashDetailViewController, type: .cashDetail)
    viewControllers = [cashNavigationController, cashDetailNavigationController]
  }

  func navigationController(with rootViewController: UIViewController?, type: TabBarType) -> UINavigationController {
    guard let rootViewController = rootViewController else {
      fatalError("UIViewController for \(Self.self) is nil")
    }
    let image = type.image?.maskWithColor(color: .plainGray)
    let selectedImage = type.image?.maskWithColor(color: .white)
    let navigationController = UINavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
    return navigationController
  }

}

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    selectedViewController = viewController
  }

}
