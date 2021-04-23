//  
//  CardDetailInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

// MARK: - CardDetailInteractor
class CardDetailInteractor {
    
    private let cardManager: CardManager
    
    init(cardManager: CardManager) {
        self.cardManager = cardManager
    }
}

// MARK: - CardDetailInteractorProtocol
extension CardDetailInteractor: CardDetailInteractorProtocol {
    
    func deleteCardModel(_ model: CardModel, callback: @escaping (Error?) -> Void) {
        cardManager.deleteModel(model, callback: callback)
    }
}
