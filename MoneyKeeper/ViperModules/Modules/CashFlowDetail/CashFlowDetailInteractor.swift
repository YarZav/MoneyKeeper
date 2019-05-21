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
    private var dao: DAO
    private var mapper: ModelMapper
    
    //Init
    init(dao: DAO, mapper: ModelMapper) {
        self.dao = dao
        self.mapper = mapper
    }
}

// MARK: - CashFlowDetailInteractorProtocol
extension CashFlowDetailInteractor: CashFlowDetailInteractorProtocol {
    
    func getCashFlowDetails() -> [CashFlowModel] {
        let coreDataModels = self.dao.getCashFlowCoreDataModels()
        let models = coreDataModels.compactMap { self.mapper.cashFlowMapping($0) }
        return models
    }
    
    func deleteModel(_ model: CashFlowModel) {
        self.dao.deleteCashFlowCoreDataModelBy(id: model.id)
        self.dao.save()
    }
}
