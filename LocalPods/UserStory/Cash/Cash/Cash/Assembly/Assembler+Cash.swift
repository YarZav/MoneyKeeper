//
//  Assembler+Cash.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 8/6/22.
//

import Swinject
import Business

extension Assembler {

  public func getCash() -> CashProtocol {
    guard let cashView = resolver.resolve(CashViewProtocol.self) else {
      fatalError("Fatal Error (Swinject): CashViewProtocol is not in container")
    }
    guard let cash = cashView as? CashProtocol else {
      fatalError("Fatal Error (Swinject): CashProtocol is not in container")
    }
    return cash
  }

  public func getCashCategory(_ cashModel: CashModel) -> CashCategoryProtocol {
    guard let cashCategoryView = resolver.resolve(CashCategoryViewProtocol.self) else {
      fatalError("Fatal Error (Swinject): CashCategoryViewProtocol is not in container")
    }
    guard var cashCategory = cashCategoryView as? CashCategoryProtocol else {
      fatalError("Fatal Error (Swinject): CashCategoryProtocol is not in container")
    }
    cashCategory.cashModel = cashModel
    return cashCategory
  }

}
