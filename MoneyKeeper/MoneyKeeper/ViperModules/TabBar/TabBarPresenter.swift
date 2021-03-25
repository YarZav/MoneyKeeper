//
//  TabBarPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

class TabBarPresenterImp {

  private weak var view: TabBarView?
  private let interactor: TabBarInteractor
  private let wireFrame: TabBarWireFrame

  init(view: TabBarView?, interactor: TabBarInteractor, wireFrame: TabBarWireFrame) {
    self.view = view
    self.interactor = interactor
    self.wireFrame = wireFrame
  }
}

// MARK: - Privates
private extension TabBarPresenterImp {

  func navigaitonController(for type: TabBarButtonType) -> UINavigationController {
    return self.wireFrame.getNavigationController(by: type)
  }
}

// MARK: - TabBarPresenter
extension TabBarPresenterImp: TabBarPresenter {
  func viewDidLoad() {
    let navigationControllers = TabBarButtonType.allCases.compactMap { navigaitonController(for: $0) }
    self.view?.tabBarControllers(navigationControllers)
  }
}
