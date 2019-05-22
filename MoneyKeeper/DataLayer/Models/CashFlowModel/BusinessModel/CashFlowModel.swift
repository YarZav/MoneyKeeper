//
//  CashFlowModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 21.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowType
enum CashFlowType: Int {
    case consumption = 0        // Расходы
    case income      = 1        // Доходы
    
    //FIXME: Локализация
    var title: String {
        switch self {
        case .consumption:  return "Расходы"
        case .income:       return "Доходы"
        }
    }
}

// MARK: - CashFlowModel
class CashFlowModel {
    
    /// identifier of model
    var id: String = UUID().uuidString
    
    /// Cash flow transaction type
    var type: CashFlowType
    
    /// Total price
    var price: NSNumber
    
    /// Date of transaction
    var date: Date
    
    /// Service for transaction
    var serviceModel: ServiceModel

    // Init
    init(type: CashFlowType) {
        self.type = type
        self.price = NSNumber(value: 0)
        self.date = Date()
        self.serviceModel = ServiceModel(title: "", imageName: "")
    }
}

// MARK: - Publics
extension CashFlowModel {
    
    public func getPriceAsString(numberStyle: NumberFormatter.Style) -> String {
        let numberFormatter = NumberFormatter.numberFormatter(numberStyle: numberStyle)
        let price = numberFormatter.string(from: self.price) ?? ""
        return price
    }
}
