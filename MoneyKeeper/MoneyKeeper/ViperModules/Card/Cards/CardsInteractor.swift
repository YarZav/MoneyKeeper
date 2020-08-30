//
//  CardsInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CardsInteractor
class CardsInteractor {
    
    private let cardManager: CardManager
    
    init(cardManager: CardManager) {
        self.cardManager = cardManager
    }
}

// MARK: - CardsInteractorProtocol
extension CardsInteractor: CardsInteractorProtocol {
    
    func getCards() -> [CardModel] {
        return cardManager.getModels() ?? []
    }
    
    func saveCard(_ model: CardModel, callback: @escaping (Error?) -> Void) {
        cardManager.saveModel(model, callback: callback)
    }
}
