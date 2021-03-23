//
//  CashInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CashInteractor
class CashInteractor {
    
    //Properties
    private let cashManager: CashManager
    
    //Init
    init(cashManager: CashManager) {
        self.cashManager = cashManager
    }
}

// MARK: - CashInteractorProtocol
extension CashInteractor: CashInteractorProtocol {
    
    func getTotalCash(type: CashType) -> Decimal {
//        return self.cashFlowManager.getTotalPriceCashFlow(by: type)
        return 0
    }
}

