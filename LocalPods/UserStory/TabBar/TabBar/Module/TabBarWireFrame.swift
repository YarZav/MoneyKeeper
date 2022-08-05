//
//  TabBarWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import Cash
import Swinject

final class TabBarWireFrameImp {

    private let cashView: CashView

    init(cashView: CashView) {
        self.cashView = cashView
    }

}

// MARK: - TabBarWireFrame

extension TabBarWireFrameImp: TabBarWireFrame {

  func cashNavigationController() -> UINavigationController {
    guard let cashViewController = cashView as? UIViewController else { return UINavigationController() }
    let navigationController = UINavigationController(rootViewController: cashViewController)
    navigationController.tabBarItem.title = nil
    navigationController.tabBarItem.image = TabBarButtonType.cash.image
    return navigationController
  }
}
