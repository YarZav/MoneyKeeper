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

// MARK: - Privates
extension TabBarPresenter {
    
    private func getNavigaitonController(for type: TabBarButtonType) -> UINavigationController {
        return self.wireFrame.getNavigationController(by: type)
    }
}

// MARK: - TabBarPresenterProtocol
extension TabBarPresenter: TabBarPresenterProtocol {
    
    func createTabBarControlelrs(for types: [TabBarButtonType]) {
        let navigationControllers = types.compactMap { self.getNavigaitonController(for: $0) }
        self.view?.createTabBarControllers(controlelrs: navigationControllers)
    }
}
