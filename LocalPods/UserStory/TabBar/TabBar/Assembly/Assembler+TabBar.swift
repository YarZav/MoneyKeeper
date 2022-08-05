//
//  TabBarAssembler.swift
//  TabBar
//
//  Created by Yaroslav Zavyalov on 8/5/22.
//

import Swinject

extension Assembler {

  public func tabBarViewController() -> UIViewController {
    guard let viewController = resolver.resolve(TabBarViewProtocol.self) as? TabBarViewController else {
      fatalError("Fatal Error (Swinject): TabBarViewProtocol is not UIViewController")
    }
    return viewController
  }

}
