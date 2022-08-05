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
    registerTabBarView(container: container)
    registerTabBarWireFrame(container: container)
    registerTabBarPresenter(container: container)
  }

}

// MARK: - Private

private extension TabBarAssembly {

  func registerTabBarView(container: Container) {
    container.register(TabBarViewProtocol.self) {
      guard let presenter = $0.resolve(TabBarPresenterProtocol.self) else {
        fatalError("TabBarWireFrame is not in container")
      }
      return TabBarViewController(presenter: presenter)
    }.inObjectScope(.container)
  }

  func registerTabBarWireFrame(container: Container) {
    container.register(TabBarWireFrameProtocol.self) {
      guard let cashView = $0.resolve(CashView.self) else {
        fatalError("CashView is not in container")
      }
      guard let cashViewController = cashView as? UIViewController else {
        fatalError("CashView is not UIViewController")
      }
      return TabBarWireFrame(cashViewController: cashViewController)
    }.inObjectScope(.container)
  }

  func registerTabBarPresenter(container: Container) {
    container.register(TabBarPresenterProtocol.self) {
      guard let wireFrame = $0.resolve(TabBarWireFrameProtocol.self) else {
        fatalError("TabBarWireFrameProtocol is not in container")
      }
      return TabBarPresenter(wireFrame: wireFrame)
    }.initCompleted { resolver, presenter in
      (presenter as? TabBarPresenter)?.view = resolver.resolve(TabBarViewProtocol.self)
    }.inObjectScope(.container)
  }

}
