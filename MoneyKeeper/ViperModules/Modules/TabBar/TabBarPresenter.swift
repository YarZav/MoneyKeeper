//
//  TabBarPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarPresenter
class TabBarPresenter: BasePresenter {

    //Properties
    private weak var view: TabBarViewControllerProtocol?
    private let interactor: TabBarInteractorProtocol
    private let wireFrame: TabBarWireFrameProtocol

    //Init
    init(view: TabBarViewControllerProtocol, interactor: TabBarInteractorProtocol, wireFrame: TabBarWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - TabBarPresenterProtocol
extension TabBarPresenter: TabBarPresenterProtocol {
    
    func createTabBarControlelrs() {
        let cashFlowNavigationController = self.wireFrame.getCashFlowNavigationController()
        let cashFlowDetailNavigationController = self.wireFrame.getCashFlowDetailNavigationController()
        let cardNavigationController = self.wireFrame.getCardNavigationController()
        let goalNavigationController = self.wireFrame.getGoalNavigationController()
        let settingNavigationController = self.wireFrame.getSettingNavigationController()
        let navigationControllers = [cashFlowNavigationController, cashFlowDetailNavigationController, cardNavigationController, goalNavigationController, settingNavigationController]
        self.view?.createTabBarControllers(controlelrs: navigationControllers)
    }
}
