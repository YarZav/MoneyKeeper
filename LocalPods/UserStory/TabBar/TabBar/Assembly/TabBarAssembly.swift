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

  // MARK: - Init

  public init() { }

}

// MARK: - Assembly

extension TabBarAssembly: Assembly {

  public func assemble(container: Container) {
    registerTabBarView(container: container)
  }

}

// MARK: - Private

private extension TabBarAssembly {

  func registerTabBarView(container: Container) {
    container.register(TabBarViewProtocol.self) { _ in
      return TabBarViewController()
    }.inObjectScope(.container)
  }

}
