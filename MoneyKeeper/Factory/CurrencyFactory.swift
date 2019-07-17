//
//  CurrencyFactory.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

/// Currency code
enum CurrencyCode: Int, CaseIterable {
    
    /// Russian currency
    case ruble = 0
    
    /// English currency
    case dollarUSA = 1
    
    /// Code for currency
    var code: String {
        switch self {
        case .ruble: return "₽"
        case .dollarUSA: return "$"
        }
    }
}

// MARK: - Public
class CurrencyFactory {
    
    /// Get all curencies
    public static func models() -> [CurrencyModel] {
        return CurrencyCode.allCases.compactMap { CurrencyModel(isOn: false, code: $0) }
    }
}
