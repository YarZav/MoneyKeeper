//
//  CashFlowInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CashFlowInteractor
class CashFlowInteractor {
    
    //Properties
    private let cashFlowManager: CashFlowManager
    
    //Init
    init(cashFlowManager: CashFlowManager) {
        self.cashFlowManager = cashFlowManager
    }
}

// MARK: - CashFlowInteractorProtocol
extension CashFlowInteractor: CashFlowInteractorProtocol {
    
    func getTotalCashFlow(type: CashFlowType) -> Decimal {
//        return self.cashFlowManager.getTotalPriceCashFlow(by: type)
        return 0
    }
}

