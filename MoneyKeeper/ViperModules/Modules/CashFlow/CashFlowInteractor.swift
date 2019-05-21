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
    private var dao: CashFlowCoreDataProtocol
    private var mapper: CashFlowMapperProtocol
    
    //Init
    init(dao: CashFlowCoreDataProtocol, mapper: CashFlowMapperProtocol) {
        self.dao = dao
        self.mapper = mapper
    }
}

// MARK: - CashFlowInteractorProtocol
extension CashFlowInteractor: CashFlowInteractorProtocol {
    
    func getCashFlowModels() -> [CashFlowModel] {
        let cashFlowCoreDataModels = self.dao.getCashFlowCoreDataModels()
        let cashFlowModels = cashFlowCoreDataModels.compactMap { self.mapper.cashFlowMapping($0) }
        return cashFlowModels
    }
}

