//
//  Card+ModelMapping.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - CardModelMapper
extension ModelMapper {
    
    //Model -> CoreData
    func cardMapping(_ model: CardModel?) -> CardCoreDataModel? {
        guard let model = model else { return nil }
        
        let cardCoreDataModel = CardCoreDataModel()
        cardCoreDataModel.identifier = model.id
        cardCoreDataModel.addDate = model.addDate
        cardCoreDataModel.code = model.code
        cardCoreDataModel.type = model.type.rawValue
        cardCoreDataModel.title = model.title
        
        return cardCoreDataModel
    }
    
    //[Model] -> [CoreData]
    func cardMapping(_ models: [CardModel]?) -> [CardCoreDataModel]? {
        return models?.compactMap({ self.cardMapping($0) })
    }
    
    //CoreData -> Model
    func cardMapping(_ model: CardCoreDataModel?) -> CardModel? {
        guard let model = model else { return nil }
        
        let cardModel = CardModel(code: model.code, type: AVMetadataObject.ObjectType(rawValue: model.type), title: model.title)
        cardModel.id = model.identifier
        cardModel.addDate = model.addDate
        
        return cardModel
    }
    
    //[CoreData] -> [Model]
    func cardMapping(_ models: [CardCoreDataModel]?) -> [CardModel]? {
        return models?.compactMap({ self.cardMapping($0) })
    }
}
