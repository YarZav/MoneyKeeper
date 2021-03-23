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
  func getCardCoreDataModels() -> [CardCoreDataModel]?
  func deleteCardCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void)
  func saveCardCoreDataModel(_ model: CardCoreDataModel, callback: @escaping (Error?) -> Void)
}

// MARK: - CardDAO
class CardDAO {
  private let coreDataManager: CoreDataManager
  
  init(coreDataManager: CoreDataManager) {
    self.coreDataManager = coreDataManager
  }
}

extension CardDAO: CardDAOProtocol {
  func getCardCoreDataModels() -> [CardCoreDataModel]? {
//    let cardCoreDataModels = userCoreDataModel.cards?.allObjects as? [CardCoreDataModel]
//    return cardCoreDataModels
    return nil
  }

  func deleteCardCoreDataModelBy(id: String, callback: @escaping (Error?) -> Void) {
//    let cardCoreDataModels = getCardCoreDataModels(for: userCoreDataModel)
//    if let cardCoreDataModel = cardCoreDataModels?.first(where: { $0.identifier == id }) {
//      coreDataManager.managedObjectContext.delete(cardCoreDataModel)
//      coreDataManager.saveContext(callback: callback)
//    } else {
//      callback(nil)
//    }
  }
    
  func saveCardCoreDataModel(_ model: CardCoreDataModel, callback: @escaping (Error?) -> Void) {
//    var cardCoreDataModels = (userCoreDataModel.cards?.allObjects) as? [CardCoreDataModel]
//
//    if cardCoreDataModels == nil {
//      userCoreDataModel.cards = NSSet(array: [model])
//    } else {
//      cardCoreDataModels?.append(model)
//      userCoreDataModel.cards = NSSet(array: (cardCoreDataModels ?? []))
//    }
//    
//    coreDataManager.saveContext(callback: callback)
  }
}
