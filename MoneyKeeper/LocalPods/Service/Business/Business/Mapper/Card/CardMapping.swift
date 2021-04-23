//
//  CardMapper.swift
//  Business
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import AVFoundation
import DataBase

// MARK: - CardMapper
final class CardMapper {
  func map(_ cardModel: CardModel?) -> CardDBModel? {
    guard let cardModel = cardModel else { return nil }
    let cardDBModel = CardDBModel()
    cardDBModel.identifier = cardModel.identifier
    cardDBModel.date = cardModel.date
    cardDBModel.code = cardModel.code
    cardDBModel.type = cardModel.type.rawValue
    cardDBModel.title = cardModel.title
    return cardDBModel
  }

  func map(_ cardDBModel: CardDBModel?) -> CardModel? {
    guard let cardDBModel = cardDBModel else { return nil }
    return CardModel(identifier: cardDBModel.identifier,
                     date: cardDBModel.date,
                     code: cardDBModel.code,
                     type: AVMetadataObject.ObjectType(rawValue: cardDBModel.type),
                     title: cardDBModel.title)
  }
}
