//
//  CurrencyModel.swift
//  MoneyKeeper
//
//  Created by admin on 13/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// Currency for settings
class CurrencyModel {
    
    /// Currency enabled
    var isOn: Bool
    
    /// Currency code
    var code: CurrencyCode
    
    init(isOn: Bool, code: CurrencyCode) {
        self.isOn = isOn
        self.code = code
    }
}

// MARK: - Protocol for single selection table
extension CurrencyModel: SingleSelectionModel {
    
    func setSelection(_ selection: Bool) {
        self.isOn = selection
    }
    
    func getTitle() -> String {
        return self.code.code
    }
    
    func isSelection() -> Bool {
        return self.isOn
    }
}
