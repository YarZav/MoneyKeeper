//
//  String+Extension.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

extension String {
    
    /// String to double
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    /// Localized string
    func localized() -> String {
        let settingsManager = SettingsManager.sharedInstance
        guard let languageType = settingsManager.getSettings()?.languageModel.code else { return self }
        
        if let path = Bundle.main.path(forResource: languageType.code, ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        
        return self
    }
    
    /// Create Decimal string from number
    mutating func addNumberToPriceString(_ number: Int, pointSymbol: String?) {
        if self == "0" {
            self.removeFirst()
        }
        
        if let pointSymbol = pointSymbol, let range = self.range(of: pointSymbol), String(self[range.upperBound...]).count == 2 {
            return
        }
        self.append("\(number)")
    }
    
    /// Add decimal separator to Decimal string
    mutating func addDecimalSeparator(_ decimapSeparator: String) {
        if self.count == 0 {
            self = "0" + decimapSeparator
        } else if !self.contains(decimapSeparator) {
            self.append(decimapSeparator)
        }
    }
    
    /// Delete last charater from decimal separator
    mutating func deleteLastCharacter() {
        if self == "0" { return }
        self.removeLast()
        if self.count == 0 { self = "0" }
    }
}
