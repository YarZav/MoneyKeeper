//
//  CurrencyModel.swift
//  MoneyKeeper
//
//  Created by admin on 13/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

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
        isOn = selection
    }
    
    func getTitle() -> String {
        return code.title
    }
    
    func isSelection() -> Bool {
        return isOn
    }
}
