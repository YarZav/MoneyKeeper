//
//  CashInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Business

final class CashInteractor {

  // MARK: - Private property

  private let cashDAO: CashDAO

  // MARK: - Init

  init(cashDAO: CashDAO) {
    self.cashDAO = cashDAO
  }

}

// MARK: - CashInteractorProtocol

extension CashInteractor: CashInteractorProtocol {

  func getTotalCash() -> Decimal {
    let cashModels = cashDAO.getAll()
    let price = cashModels?.compactMap { $0.price }.reduce(0, +) ?? 0
    return Decimal(price)
  }

}

