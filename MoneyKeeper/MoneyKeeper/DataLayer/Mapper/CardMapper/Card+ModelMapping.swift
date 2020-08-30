//
//  Card+ModelMapping.swift
//  MoneyKeeper
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import AVFoundation

// MARK: - CardModelMapper
class CardModelMapper {
  func map(_ model: CardModel?) -> CardCoreDataModel? {
    guard let model = model else { return nil }
    let cardCoreDataModel = CardCoreDataModel()
    cardCoreDataModel.identifier = model.id
    cardCoreDataModel.addDate = model.addDate
    cardCoreDataModel.code = model.code
    cardCoreDataModel.type = model.type.rawValue
    cardCoreDataModel.title = model.title
    return cardCoreDataModel
  }

  func map(_ model: CardCoreDataModel?) -> CardModel? {
    guard let model = model else { return nil }
    let cardModel = CardModel(code: model.code, type: AVMetadataObject.ObjectType(rawValue: model.type), title: model.title)
    cardModel.id = model.identifier
    cardModel.addDate = model.addDate
    return cardModel
  }
}
