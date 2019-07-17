//
//  Card+ModelMapping.swift
//  MoneyKeeper
//
//  Created by admin on 27/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CardModelMapper
extension ModelMapper {
    
    //Model -> CoreData
    func cardMapping(_ model: CardModel?) -> CardCoreDataModel? {
        if let model = model {
            let cardCoreDataModel = CardCoreDataModel()
            cardCoreDataModel.identifier = model.id
            cardCoreDataModel.codeType = model.codeType
            cardCoreDataModel.codeValue = model.codeValue
            
            return cardCoreDataModel
        }
        
        return nil
    }
    
    //CoreData -> Model
    func serviceMapping(_ model: CardCoreDataModel?) -> CardModel? {
        if let model = model {
            let cardModel = CardModel(id: model.identifier, codeType: model.codeType, codeValue: model.codeValue)
            
            return cardModel
        }
        
        return nil
    }
}
