////
////  CashMapper.swift
////  Business
////
////  Created by Yaroslav Zavyalov on 03/02/2019.
////  Copyright © 2019 ZYG. All rights reserved.
////
//
//import AVFoundation
//import DataBase
//
//// MARK: - CashMapper
//final class CashMapper {
//  func map(_ cashModel: CashModel?) -> CashDBModel? {
//    guard let cashModel = cashModel else { return nil }
//    guard let categoryDBModel = CategoryMapper().map(cashModel.category) else { return nil }
//    let cashDBModel = CashDBModel()
//    cashDBModel.identifier = cashModel.identifier
//    cashDBModel.price = (cashModel.price as NSNumber).doubleValue
//    cashDBModel.type = Int64(cashModel.type.rawValue)
//    cashDBModel.date = cashModel.date
//    cashDBModel.category = categoryDBModel
//    return cashDBModel
//  }
//      
//  func map(_ cashDBModel: CashDBModel?) -> CashModel? {
//    guard let cashDBModel = cashDBModel, let type = CashType(rawValue: Int(cashDBModel.type)) else { return nil }
//    guard let categoryModel = CategoryMapper().map(cashDBModel.category) else { return nil }
//    return CashModel(identifier: cashDBModel.identifier,
//                     type: type,
//                     price: Decimal(cashDBModel.price),
//                     date: cashDBModel.date,
//                     category: categoryModel)
//  }
//}
