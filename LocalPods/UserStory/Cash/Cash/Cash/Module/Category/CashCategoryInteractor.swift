//
//  CashCategoryInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Business

final class CashCategoryInteractor {

  private let cashDAO: CashDAO

  init(cashDAO: CashDAO) {
    self.cashDAO = cashDAO
  }

}

// MARK: - CashCategoryInteractorProtocol

extension CashCategoryInteractor: CashCategoryInteractorProtocol {

  func saveCash(_ cashModel: CashModel, callback: @escaping (Error?) -> Void) {
    cashDAO.save(cashModel, callback: callback)
  }
}
