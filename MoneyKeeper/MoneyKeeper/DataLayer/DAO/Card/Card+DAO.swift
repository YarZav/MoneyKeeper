//
//  CardCoreDataModel+DAO.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

protocol CardDAOProtocol {
    func getCardCoreDataModels(for userCoreDataModel: UserCoreDataModel) -> [CardCoreDataModel]?
    func deleteCardCoreDataModelBy(id: String, for userCoreDataModel: UserCoreDataModel, callback: @escaping (Error?) -> Void)
    func saveCardCoreDataModel(_ model: CardCoreDataModel, for userCoreDataModel: UserCoreDataModel, callback: @escaping (Error?) -> Void)
}

// MARK: - CardDAO
class CardDAO {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

extension CardDAO: CardDAOProtocol {
    /// Get all cards for user
    func getCardCoreDataModels(for userCoreDataModel: UserCoreDataModel) -> [CardCoreDataModel]? {
        let cardCoreDataModels = userCoreDataModel.cards?.allObjects as? [CardCoreDataModel]
        return cardCoreDataModels
    }

    /// Delete card model by identifier
    func deleteCardCoreDataModelBy(id: String, for userCoreDataModel: UserCoreDataModel, callback: @escaping (Error?) -> Void) {
        let cardCoreDataModels = getCardCoreDataModels(for: userCoreDataModel)
        if let cardCoreDataModel = cardCoreDataModels?.first(where: { $0.identifier == id }) {
            coreDataManager.managedObjectContext.delete(cardCoreDataModel)
            coreDataManager.saveContext(callback: callback)
        } else {
            callback(nil)
        }
    }
    
    /// Save new card model
    func saveCardCoreDataModel(_ model: CardCoreDataModel, for userCoreDataModel: UserCoreDataModel, callback: @escaping (Error?) -> Void) {
        var cardCoreDataModels = (userCoreDataModel.cards?.allObjects) as? [CardCoreDataModel]
        
        if cardCoreDataModels == nil {
            userCoreDataModel.cards = NSSet(array: [model])
        } else {
            cardCoreDataModels?.append(model)
            userCoreDataModel.cards = NSSet(array: (cardCoreDataModels ?? []))
        }
        
        coreDataManager.saveContext(callback: callback)
    }
}
