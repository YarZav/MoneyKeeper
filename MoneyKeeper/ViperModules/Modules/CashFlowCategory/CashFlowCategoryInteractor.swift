//
//  CashFlowCategoryInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation

// MARK: - CashFlowCategoryInteractor
class CashFlowCategoryInteractor {
    
    // Properties
    private var dao: DAO
    private var mapper: ModelMapper
    
    // Init
    init(dao: DAO, mapper: ModelMapper) {
        self.dao = dao
        self.mapper = mapper
    }
}

// MARK: - CashFlowCategoryInteractorProtocol
extension CashFlowCategoryInteractor: CashFlowCategoryInteractorProtocol {
    
    func getCategoryItems() -> [ServiceModel] {
        //FIXME: Create default services in create UserAccountMethod
        let userCoreDataModel = self.dao.getUserCoreDataModel()
        if let userServiceCoreDataModels = userCoreDataModel?.services?.allObjects as? [ServiceCoreDataModel],  userServiceCoreDataModels.count > 0 {
            let services = userServiceCoreDataModels.compactMap { self.mapper.serviceMapping($0) }
            return services
        } else {
            let services = ServiceModel.defaultModels()
            let userServiceCoreDataModels = services.compactMap { self.mapper.serviceMapping($0) }
            userCoreDataModel?.services = NSSet(array: userServiceCoreDataModels)
            self.dao.save()
            print("Created user default services: \(String(describing: userCoreDataModel))")
            return services
        }
    }
    
    func saveCashFlowModel(_ model: CashFlowModel) {
        if let cashFlowCoreDataModel = self.mapper.cashFlowMapping(model) {
            let userCoreDataModel = self.dao.getUserCoreDataModel()
            var cashFlowCoreDataModels = userCoreDataModel?.cashFlows?.allObjects ?? []
            cashFlowCoreDataModels.append(cashFlowCoreDataModel)
            userCoreDataModel?.cashFlows = NSSet(array: cashFlowCoreDataModels)
            self.dao.save()
        }
    }
}
