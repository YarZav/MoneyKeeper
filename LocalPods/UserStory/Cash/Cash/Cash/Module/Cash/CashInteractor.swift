//
//  CashInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import CoreData
import Business

final class CashInteractorImp {

  private let cashDAO: CashDAO

  init(cashDAO: CashDAO) {
    self.cashDAO = cashDAO
  }

}

// MARK: - CashInteractor

extension CashInteractorImp: CashInteractor {
    
  func getTotalCash() -> Decimal {
    let cashModels = cashDAO.getAll()
    let price = cashModels?.compactMap { $0.price }.reduce(0, +) ?? 0
    return Decimal(price)
  }

}

