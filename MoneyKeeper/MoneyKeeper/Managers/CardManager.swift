//
//  CardManager.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

/// Thread safe manager to get and set card models
class CardManager {
  private let isolationQueue = DispatchQueue(label: "com.MoneyKeeper.Card", qos: .userInteractive, attributes: .concurrent)
  private let dao: CardDAOProtocol
  
  init(dao: CardDAOProtocol) {
    self.dao = dao
  }
}

// MARK: - Publics
extension CardManager {
  /// Thread safe add card models to CoreData
  public func saveModel(_ model: CardModel, callback: @escaping (Error?) -> Void) {
//      guard let cardCoreDataModel = self.dao.mapper.cardMapping(model) else {
//        let error = CustomError(title: "Card model map error", description: "Unavailable to map business model to coredata model", code: -1)
//        callback(error)
//        return
//      }
//
//      self.isolationQueue.async(flags: .barrier) {
//        self.dao.saveCardCoreDataModel(cardCoreDataModel, callback: callback)
//      }
  }
    
  /// Thread safe get card models from CoreData
  public func getModels() -> [CardModel]? {
//      var cardCoreDataModels: [CardCoreDataModel]?
//      self.isolationQueue.sync {
//        cardCoreDataModels = self.dao.getCardCoreDataModels()
//      }
//      return self.dao.mapper.cardMapping(cardCoreDataModels)
    fatalError()
  }
    
  /// Thread safe delete card model from CoreData
  public func deleteModel(_ model: CardModel, callback: @escaping (Error?) -> Void) {
//      self.isolationQueue.async(flags: .barrier) {
//        self.dao.deleteCardCoreDataModelBy(id: model.id, callback: callback)
//      }
  }
}
