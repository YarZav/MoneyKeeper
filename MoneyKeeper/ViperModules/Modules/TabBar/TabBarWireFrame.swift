//
//  TabBarWireFrame.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarWireFrame
class TabBarWireFrame: BaseWireFrame { }

// MARK: - TabBarWireFrameProtocol
extension TabBarWireFrame: TabBarWireFrameProtocol {
    
    func getCashFlowNavigationController() -> UINavigationController {
        let rootViewController = self.resolver.cashFlowViewCotnroller()
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.transparentNavigationBar()
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationController
    }
    
    func getCashFlowDetailNavigationController() -> UINavigationController {
        let rootViewController = self.resolver.cashFlowDetailViewCotnroller()
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = .anthracite
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.shadowImage = UIImage.imageWithColor(color: .darkGray)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationController
    }
    
    func getCardNavigationController() -> UINavigationController {
        let rootViewController = BaseViewController()
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        return navigationController
    }
    
    func getGoalNavigationController() -> UINavigationController {
        let rootViewController = BaseViewController()
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        return navigationController
    }
    
    func getSettingNavigationController() -> UINavigationController {
        let rootViewController = BaseViewController()
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        return navigationController
    }
}
