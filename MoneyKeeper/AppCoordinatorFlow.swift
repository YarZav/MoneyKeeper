//
//  AppCoordinatorFlow.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 8/11/22.
//

import TabBar
import DI
import OverlayContainer
import Cash
import DesignSystem
import Business

// TODO: - Сделать отдельный файл
protocol AppCoordinatorFlowProtocol {

  var rootViewController: UIViewController? { get }

}

final class AppCoordinatorFlow {

  private let swinjectAssembly = SwinjectAssembly(with: [TabBarAssembly(), CashAssembly()])
  private var overlayViewController: OverlayViewController?

}

extension AppCoordinatorFlow: AppCoordinatorFlowProtocol {

  var rootViewController: UIViewController? {
    getTabBarViewController()
  }
}

// MARK: - Private

private extension AppCoordinatorFlow {

  func getTabBarViewController() -> UIViewController? {
    var tabBar = swinjectAssembly.assembler.getTabBar()
    tabBar.cashViewController = getCashViewController()
    tabBar.cashDetailViewController = getCashDetailViewController()
    let viewController = tabBar as? UIViewController
    return viewController
  }

  func getCashViewController() -> UIViewController? {
    var cash = swinjectAssembly.assembler.getCash()
    let cashViewController = cash as? UIViewController

    cash.category = { [weak cashViewController, weak self] cashModel, compeltion in
      let cashCategoryViewController = self?.getCashCategoryViewController(cashModel, completion: compeltion)
      self?.presentOverlayController(cashViewController, toViewController: cashCategoryViewController)
    }

    return cashViewController
  }

  func getCashDetailViewController() -> UIViewController? {
    let cashDetail = swinjectAssembly.assembler.getCashDetail()
    let cashDetailViewController = cashDetail as? UIViewController
    return cashDetailViewController
  }

  func getCashCategoryViewController(_ cashModel: CashModel, completion: (() -> Void)?) -> UIViewController? {
    var cashCategory = swinjectAssembly.assembler.getCashCategory(cashModel)
    // TODO: - cashCategory кем-то удерживается в памяти
    cashCategory.isOpened = false
    let cashCategoryViewController = cashCategory as? UIViewController

    cashCategory.hide = { [weak self] in
      self?.hideOverlayController(nil)
    }

    cashCategory.completion = { [weak self] in
      self?.hideOverlayController(completion)
    }

    return cashCategoryViewController
  }

}

// MARK: - Overlay controller

extension AppCoordinatorFlow {

  func presentOverlayController(_ fromViewController: UIViewController?, toViewController: UIViewController?) {
    guard let fromViewController = fromViewController, let toViewController = toViewController else {
      fatalError("fromViewController and toViewController are not UIViewController")
    }

    guard let overlayDelegate = toViewController as? OverlayContainerViewControllerDelegate else {
      fatalError("Module should be OverlayContainerViewControllerDelegate")
    }

    let overlayContainer = OverlayViewController(style: .expandableHeight)
    let bounds = UIScreen.main.bounds
    overlayContainer.view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    overlayContainer.delegate = overlayDelegate
    overlayContainer.viewControllers = [toViewController]
    overlayViewController = overlayContainer

    fromViewController.addChild(overlayContainer)
    fromViewController.view.addSubview(overlayContainer.view)
    overlayContainer.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      overlayContainer.view.topAnchor.constraint(equalTo: fromViewController.view.topAnchor),
      overlayContainer.view.bottomAnchor.constraint(equalTo: fromViewController.view.bottomAnchor),
      overlayContainer.view.leftAnchor.constraint(equalTo: fromViewController.view.leftAnchor),
      overlayContainer.view.rightAnchor.constraint(equalTo: fromViewController.view.rightAnchor)
    ])

    overlayContainer.view.layoutIfNeeded()
    overlayContainer.moveOverlay(toNotchAt: 1, animated: true)
  }

  func hideOverlayController(_ completion: (() -> Void)?) {
    overlayViewController?.hide(animated: true, completion: completion)
  }

}

