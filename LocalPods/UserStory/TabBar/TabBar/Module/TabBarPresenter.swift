//
//  TabBarPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

final class TabBarPresenterImp {

  // MARK: - Private property

  private let wireFrame: TabBarWireFrame

  // MARK: - Internal property

  weak var view: TabBarView?

  // MARK: - Init

  init(wireFrame: TabBarWireFrame) {
    self.wireFrame = wireFrame
  }

}

// MARK: - TabBarPresenter

extension TabBarPresenterImp: TabBarPresenter {

  func viewWillAppear() {
    let cashNavigationController = wireFrame.cashNavigationController()
    view?.tabBarControllers([cashNavigationController])
  }

}
