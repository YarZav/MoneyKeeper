//
//  TabBarPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

final class TabBarPresenter {

  // MARK: - Private property

  private let wireFrame: TabBarWireFrameProtocol

  // MARK: - Internal property

  weak var view: TabBarViewProtocol?

  // MARK: - Init

  init(wireFrame: TabBarWireFrameProtocol) {
    self.wireFrame = wireFrame
  }

}

// MARK: - TabBarPresenterProtocol

extension TabBarPresenter: TabBarPresenterProtocol {

  func viewWillAppear() {
    let cashNavigationController = wireFrame.cashNavigationController()
    view?.tabBarControllers([cashNavigationController])
  }

}
