//
//  CashInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import CoreData

class CashInteractorImp {
    
  //Properties
  private let cashManager: CashManager
  
  //Init
  init(cashManager: CashManager) {
    self.cashManager = cashManager
  }
}

// MARK: - CashInteractor
extension CashInteractorImp: CashInteractor {
    
  func getTotalCash(type: CashType) -> Decimal {
//        return self.cashFlowManager.getTotalPriceCashFlow(by: type)
    return 0
  }
}

