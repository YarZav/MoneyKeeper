//
//  TabBarAssembler.swift
//  TabBar
//
//  Created by Yaroslav Zavyalov on 8/5/22.
//

import Swinject

extension Assembler {

  public func getTabBar() -> TabBarProtocol {
    guard let tabBarView = resolver.resolve(TabBarViewProtocol.self) else {
      fatalError("Fatal Error (Swinject): TabBarViewProtocol is not in container")
    }
    guard let tabBar = tabBarView as? TabBarProtocol else {
      fatalError("Fatal Error (Swinject): TabBarViewProtocol is not in container")
    }
    return tabBar
  }

}
