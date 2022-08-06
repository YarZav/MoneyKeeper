//
//  Assembler+Cash.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 8/6/22.
//

import Swinject
import Business

extension Assembler {

  public func cash() -> UIViewController {
    guard let view = resolver.resolve(CashView.self) as? UIViewController else {
      fatalError("Fatal Error (Swinject): CashView is not UIViewController")
    }
    return view
  }

  public func category(_ cashModel: CashModel?) -> UIViewController {
    let view = resolver.resolve(CashCategoryViewProtocol.self)
    view?.cashModel = cashModel

    guard let viewController = view as? UIViewController else {
      fatalError("Fatal Error (Swinject): CashView is not UIViewController")
    }

    return viewController
  }

}
