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
  private let wireFrame: TabBarWireFrame

  init(view: TabBarView?, wireFrame: TabBarWireFrame) {
    self.view = view
    self.wireFrame = wireFrame
  }
}

// MARK: - TabBarPresenter
extension TabBarPresenterImp: TabBarPresenter {
  func viewWillAppear() {
    let navigationControllers = TabBarButtonType.allCases.compactMap { wireFrame.navigationController(for: $0) }
    view?.tabBarControllers(navigationControllers)
  }
}
