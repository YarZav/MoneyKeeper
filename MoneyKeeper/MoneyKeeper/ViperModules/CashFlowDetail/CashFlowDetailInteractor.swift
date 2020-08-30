//
//  CashFlowDetailInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 05/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowDetailInteractor
class CashFlowDetailInteractor {
    
    //Properties
    private let cashFlowManager: CashFlowManager
    
    //Init
    init(cashFlowManager: CashFlowManager) {
        self.cashFlowManager = cashFlowManager
    }
}

// MARK: - CashFlowDetailInteractorProtocol
extension CashFlowDetailInteractor: CashFlowDetailInteractorProtocol {
    func getCashFlowDetails(type: CashFlowType) -> [CashFlowModel] {
        return cashFlowManager.getModels() ?? []
    }
    
    func deleteModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void) {
        cashFlowManager.deleteModel(model, callback: callback)
    }
}
