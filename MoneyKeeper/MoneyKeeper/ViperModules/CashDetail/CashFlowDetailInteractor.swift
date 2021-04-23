//
//  CashFlowDetailInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

// MARK: - CashFlowDetailInteractor
class CashFlowDetailInteractor {
    
    //Properties
    private let cashFlowManager: CashManager
    
    //Init
    init(cashFlowManager: CashManager) {
        self.cashFlowManager = cashFlowManager
    }
}

// MARK: - CashFlowDetailInteractorProtocol
extension CashFlowDetailInteractor: CashFlowDetailInteractorProtocol {
    func getCashFlowDetails(type: CashType) -> [CashModel] {
        return cashFlowManager.getModels() ?? []
    }
    
    func deleteModel(_ model: CashModel, callback: @escaping (Error?) -> Void) {
        cashFlowManager.deleteModel(model, callback: callback)
    }
}
