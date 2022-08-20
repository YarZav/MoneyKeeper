//
//  CashDetailInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service

final class CashDetailInteractor {

  // MARK: - Private property

  private let cashDAO: CashDAO

  // MARK: - Init

  init(cashDAO: CashDAO) {
    self.cashDAO = cashDAO
  }

}

// MARK: - CashDetailInteractorProtocol

extension CashDetailInteractor: CashDetailInteractorProtocol {

  func getCashDetails(type: CashType) -> [CashModel] {
    cashDAO.getAll() ?? []
  }

}
