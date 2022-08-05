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

final class TabBarWireFrame {

    // MARK: - Private property

    // TODO: - Надо как-то изменить работу с WireFrame
    private let cashViewController: UIViewController

    // MARK: - Init

    init(cashViewController: UIViewController) {
        self.cashViewController = cashViewController
    }

}

// MARK: - TabBarWireFrameProtocol

extension TabBarWireFrame: TabBarWireFrameProtocol {

  func cashNavigationController() -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: cashViewController)
    navigationController.tabBarItem.title = nil
    navigationController.tabBarItem.image = TabBarButtonType.cash.image
    return navigationController
  }
}
