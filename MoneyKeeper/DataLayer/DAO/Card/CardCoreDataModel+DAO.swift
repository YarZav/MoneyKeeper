//
//  CardCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - CardCoreDataModel + DAO
extension DAO {
    
    /// Get all cards for user
    public func getCardCoreDataModels() -> [CardCoreDataModel]? {
        let userCoreDataModel = self.getUserCoreDataModel()
        let cardCoreDataModels = userCoreDataModel?.cards?.allObjects as? [CardCoreDataModel]
        return cardCoreDataModels
    }
    
    /// Get card model by identifier
    public func getCardCoreDataModelBy(id: String) -> CardCoreDataModel? {
        let cardCoreDataModels = self.getCardCoreDataModels()
        let cardCoreDataModel = cardCoreDataModels?.first(where: { $0.identifier == id })
        return cardCoreDataModel
    }
    
    /// Delete card model by identifier
    public func deleteCardCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void) {
        if let cardCoreDataModel = self.getCardCoreDataModelBy(id: id) {
            self.dataManager.managedObjectContext.delete(cardCoreDataModel)
            self.save(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Save new card model
    public func saveCardCoreDataModel(_ model: CardCoreDataModel, callback: @escaping (Error?) -> Void) {
        let userCoreDataModel = self.getUserCoreDataModel()
        var cardCoreDataModels = (userCoreDataModel?.cards?.allObjects) as? [CardCoreDataModel]
        
        if cardCoreDataModels == nil {
            userCoreDataModel?.cards = NSSet(array: [model])
        } else {
            cardCoreDataModels?.append(model)
            userCoreDataModel?.cards = NSSet(array: (cardCoreDataModels ?? []))
        }
        
        self.save(callback: callback)
    }
}
