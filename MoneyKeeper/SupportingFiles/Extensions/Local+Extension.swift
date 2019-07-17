//
//  Local+Extension.swift
//  MoneyKeeper
//
//  Created by admin on 04.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension Locale {
    
    /// Get current currency symbol base on device language
    static func getCurrencySymbol() -> String? {
        return Locale.current.currencySymbol
    }
}
