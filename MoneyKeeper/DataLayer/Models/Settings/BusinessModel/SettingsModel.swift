//
//  SettingsModel.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SettingsModel
class SettingsModel {
    
    /// Language type
    var languageModel: LanguageModel
    
    /// Currency type
    var curencyModel: CurrencyModel
    
    /// Push local sending
    var push: Bool = false
    
    /// save core data in iCloud
    var iCloud: Bool = false
    
    /// App pincode
    var pincode: String = ""
    
    /// Use touchID
    var touchID: Bool = false
    
    /// Show hint
    var showHint: Bool = false
    
    init(languageModel: LanguageModel, curencyModel: CurrencyModel) {
        self.languageModel = languageModel
        self.curencyModel = curencyModel
    }
}
