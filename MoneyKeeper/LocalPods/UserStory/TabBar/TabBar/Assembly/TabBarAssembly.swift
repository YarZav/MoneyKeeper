//
//  DIResolver+TabBar.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Swinject

public final class TabBarAssembly {
  public init() { }
}

extension TabBarAssembly: Assembly {
  public func assemble(container: Container) {
    container.register(TabBarView.self) { _ in
      return TabBarViewController()
    }.initCompleted { resolver, view in
      view.presenter = resolver.resolve(TabBarPresenter.self)
    }.inObjectScope(.container)

    container.register(TabBarWireFrame.self) { _ in
      return TabBarWireFrameImp()
    }.inObjectScope(.container)

    container.register(TabBarPresenter.self) {
      guard let wireFrame = $0.resolve(TabBarWireFrame.self) else {
        fatalError("TabBarWireFrame is not in container")
      }
      return TabBarPresenterImp(view: $0.resolve(TabBarView.self), wireFrame: wireFrame)
    }.inObjectScope(.container)
  }
}

public protocol TabBarAssembler {
  func tabBar(addCash: UIViewController) -> UIViewController
}

// MARK: - Assembler

extension Assembler: TabBarAssembler {
  public func tabBar(addCash: UIViewController) -> UIViewController {
    let view = resolver.resolve(TabBarView.self)
    view?.rootViewController = addCash
    
    guard let viewController = resolver.resolve(TabBarView.self) as? UIViewController else {
      fatalError("Fatal Error (Swinject): TabBarView is not UIViewController")
    }
    return viewController
  }
}
