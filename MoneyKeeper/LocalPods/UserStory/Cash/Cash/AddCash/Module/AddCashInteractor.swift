//
//  AddCashInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import CoreData
import Business

final class AddCashInteractorImp { }

// MARK: - CashInteractor
extension AddCashInteractorImp: AddCashInteractor {
    
  func getTotalCash(type: CashType) -> Decimal {
//        return self.cashFlowManager.getTotalPriceCashFlow(by: type)
    return 0
  }
}

