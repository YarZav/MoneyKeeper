//
//  LanguageModel.swift
//  MoneyKeeper
//
//  Created by admin on 13/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

// Language for settings
class LanguageModel {
    /// Language enabled
    var isOn: Bool
    
    /// Lanhiage code
    var code: LanguageCode
    
    init(isOn: Bool, code: LanguageCode) {
        self.isOn = isOn
        self.code = code
    }
}

// MARK: - Protocol for single selection table
extension LanguageModel: SingleSelectionModel {
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

