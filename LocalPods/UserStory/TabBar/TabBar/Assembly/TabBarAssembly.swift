//
//  DIResolver+TabBar.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Swinject
import Cash

public final class TabBarAssembly {

  public init() { }

}

// MARK: - Assembly

extension TabBarAssembly: Assembly {

  public func assemble(container: Container) {
    container.register(TabBarView.self) {
      guard let presenter = $0.resolve(TabBarPresenter.self) else {
        fatalError("TabBarWireFrame is not in container")
      }
      return TabBarViewController(presenter: presenter)
    }.inObjectScope(.container)

    container.register(TabBarWireFrame.self) {
      guard let cashView = $0.resolve(CashView.self) else {
        fatalError("CashView is not in container")
      }
      return TabBarWireFrameImp(cashView: cashView)
    }.inObjectScope(.container)

    container.register(TabBarPresenter.self) {
      guard let wireFrame = $0.resolve(TabBarWireFrame.self) else {
        fatalError("TabBarWireFrame is not in container")
      }
      return TabBarPresenterImp(wireFrame: wireFrame)
    }.initCompleted { resolver, presenter in
      (presenter as? TabBarPresenterImp)?.view = resolver.resolve(TabBarView.self)
    }.inObjectScope(.container)
  }

}

public protocol TabBarAssembler {

  func tabBar() -> UIViewController

}

// MARK: - TabBarAssembler

extension Assembler: TabBarAssembler {

  public func tabBar() -> UIViewController {
    guard let viewController = resolver.resolve(TabBarView.self) as? TabBarViewController else {
      fatalError("Fatal Error (Swinject): TabBarView is not UIViewController")
    }
    return viewController
  }

}
