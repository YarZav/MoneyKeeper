//
//  LanguageModel.swift
//  MoneyKeeper
//
//  Created by admin on 13/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

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
        self.isOn = selection
    }
    
    func getTitle() -> String {
        return self.code.title
    }
    
    func isSelection() -> Bool {
        return self.isOn
    }
}

