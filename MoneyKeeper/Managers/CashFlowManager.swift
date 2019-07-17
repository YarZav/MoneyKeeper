//
//  CashFlowManager.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowManagerDelegate
protocol CashFlowManagerDelegate: class {
    
    /// Call when save new cash flow
    func saveCashFlowModel(_ model: CashFlowModel)
    
    /// Call when delete cash flow
    func deleteCashFlowModel(_ model: CashFlowModel)
}

/// Thread safe manager to get and set cash flow models
class CashFlowManager {
    
    // Property
    private let isolationQueue = DispatchQueue(label: "com.MoneyKeeper.CashFlow", qos: .userInteractive, attributes: .concurrent)
    private let dao: DAO
    private var observers = [CashFlowManagerDelegate]()
    
    //Init
    init(dao: DAO) {
        self.dao = dao
    }
}

// MARK: - Publics
extension CashFlowManager {
    
    /// Thread safe add cash flow model to CoreData
    public func saveCashFlowModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void) {
        guard let cashFlowCoreDataModel = self.dao.mapper.cashFlowMapping(model) else {
            let error = CustomError(title: "CashFlow model map error", description: "Unavailable to map business model to coredata model", code: -1)
            callback(error)
            return
        }
        
        self.isolationQueue.async(flags: .barrier) {
            self.dao.saveCashFlowCoreDataModel(cashFlowCoreDataModel, callback: { (error) in
                self.observers.forEach({ (observer) in
                    observer.saveCashFlowModel(model)
                })
                callback(error)
            })
        }
    }
    
    /// Thread safe get cash flow models from CoreData
    public func getCashFlowModels(by type: CashFlowType) -> [CashFlowModel]? {
        var coreDataModels: [CashFlowCoreDataModel]?
        self.isolationQueue.sync {
            coreDataModels = self.dao.getCashFlowCoreDataModels()?.filter({ $0.type == type.rawValue })
        }
        return self.dao.mapper.cashFlowMapping(coreDataModels)
    }
    
    /// Thread safe delete cash flow model from CoreData
    public func deleteCashFlowModel(_ model: CashFlowModel, callback: @escaping (Error?) -> Void) {        
        self.isolationQueue.async(flags: .barrier) {
            self.dao.deleteCashFlowCoreDataModelBy(id: model.id, callback: { (error) in
                self.observers.forEach({ (observer) in
                    observer.deleteCashFlowModel(model)
                })
                callback(error)
            })
        }
    }
    
    /// Thread safe get total price by type (CashFlowType) from CoreData
    public func getTotalPriceCashFlow(by type: CashFlowType) -> Decimal {
        var total = 0.0
        self.isolationQueue.sync {
            let coreDataModels = self.dao.getCashFlowCoreDataModels()?.filter({ $0.type == type.rawValue })
            coreDataModels?.forEach({ total += $0.price })
        }
        return Decimal(total)
    }
    
    public func addObserver(_ observer: CashFlowManagerDelegate) {
        self.observers.append(observer)
    }
}
