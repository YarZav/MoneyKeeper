//
//  CashWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Business
import OverlayContainer

final class CashWireFrameImp {

  private let cashCategoryView: CashCategoryViewProtocol
  private var overlayViewController: OverlayViewController?

  init(cashCategoryView: CashCategoryViewProtocol) {
    self.cashCategoryView = cashCategoryView
  }

}

// MARK: - CashWireFrame

extension CashWireFrameImp: CashWireFrame {

  func pushCashCategory(from view: CashView?, cashModel: CashModel) {
    cashCategoryView.cashModel = cashModel

    guard let fromViewController = view as? UIViewController else { return }
    guard let toViewController = cashCategoryView as? UIViewController else { return }

    guard overlayViewController == nil else { return }
    guard let delegate = toViewController as? OverlayContainerViewControllerDelegate else {
      fatalError("Module should be OverlayContainerViewControllerDelegate")
    }

    let overlayContainer = OverlayViewController(style: .expandableHeight)
    let bounds = UIScreen.main.bounds
    overlayContainer.view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    overlayContainer.delegate = delegate
    overlayContainer.viewControllers = [toViewController]
    overlayContainer.showDelegate = self
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

    guard let cashCateogoryViewController = view as? CashCategoryViewController else { return }
    cashCateogoryViewController.hideViewController = { [weak self] in
      self?.overlayViewController?.hide(animated: true)
    }
  }
}

extension CashWireFrameImp: OverlayViewControllerDelegate {

  func viewDidHide() {
    overlayViewController = nil
  }

}
