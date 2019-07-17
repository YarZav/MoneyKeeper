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
    
    func addObserver(_ observer: CashFlowManagerDelegate) {
        self.cashFlowManager.addObserver(observer)
    }
    
    func getCashFlowDetails(type: CashFlowType) -> [CashFlowModel] {
        let cashFlowModels = self.cashFlowManager.getCashFlowModels(by: type)
        return cashFlowModels ?? []
    }
    
    func deleteModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void) {
        self.cashFlowManager.deleteCashFlowModel(model, callback: callback)
    }
}
