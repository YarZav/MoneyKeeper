//
//  DIResolver+TabBar.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Swinject

class TabBarResolver {
  private let container: Container

  init(container: Container) {
    self.container = container
  }

  private func module() {
    container.register(TabBarView.self) { _ in
      return TabBarViewController()
    }

    container.register(TabBarInteractor.self) { _ in
      return TabBarInteractorImp()
    }

    container.register(TabBarWireFrame.self) { _ in
      return TabBarWireFrameImp()
    }

    container.register(TabBarPresenter.self) {
      let view = $0.resolve(TabBarView.self)
      guard let interactor = $0.resolve(TabBarInteractor.self) else {
        fatalError("TabBarInteractor is not in container")
      }
      guard let wireFrame = $0.resolve(TabBarWireFrame.self) else {
        fatalError("TabBarWireFrame is not in container")
      }
      return TabBarPresenterImp(view: view, interactor: interactor, wireFrame: wireFrame)
    }
  }
}
