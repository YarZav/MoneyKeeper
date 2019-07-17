//
//  SettingsManager.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - SettingsManager
class SettingsManager {
    
    public static let sharedInstance = SettingsManager()
    public var dao: DAO?
}

// MARK: - Privates
extension SettingsManager {
    
    /// Notify changing of language
    private func notifyLanguageChanging(_ languageCode: LanguageCode) {
        switch languageCode {
        case .russian: Bundle.main.path(forResource: "ru", ofType: "lproj")
        case .english: Bundle.main.path(forResource: "en", ofType: "lproj")
        }
        
        NotificationCenter.default.post(name: Notification.Name("AppLanguageChanging"), object: nil)
    }
}

// MARK: - Common
extension SettingsManager {
    
    /// Get App language
    public func getSettings() -> SettingsModel? {
        let settingsCoreDataModel = self.dao?.getSettingsCoreDataModel()
        let settingsModel = self.dao?.mapper.settingsMapping(settingsCoreDataModel)
        return settingsModel
    }
    
    /// Get default settings in first launch
    public func getDefaultSettings() -> SettingsModel {
        let languageCode = Locale.current.languageCode
        let languageModel: LanguageModel
        let curencyModel: CurrencyModel
        
        if languageCode == "en" {
            languageModel = LanguageModel(isOn: true, code: .english)
            curencyModel = CurrencyModel(isOn: true, code: .dollarUSA)
        } else {
            languageModel = LanguageModel(isOn: true, code: .russian)
            curencyModel = CurrencyModel(isOn: true, code: .ruble)
        }
        
        let settingsModel = SettingsModel(languageModel: languageModel, curencyModel: curencyModel)
        return settingsModel
    }
}

// MARK: - Language
extension SettingsManager {
    
    /// Set App language
    public func setLanguageModel(_ model: LanguageModel, callback: @escaping (Error?) -> Void) {
        guard let oldSettingsModel = self.getSettings() else {
            let error = CustomError(title: "Settings not created", description: "Can't get language code, because settings for user not created", code: -1)
            callback(error)
            return
        }
        
        if oldSettingsModel.languageModel.code == model.code {
            let error = CustomError(title: "Language settings are equal", description: "New settings for language equal to old settings", code: -1)
            callback(error)
            return
        }
        
        self.dao?.updateSettingLanguageCode(Int64(model.code.rawValue)) { (error) in
            if error == nil {
                self.notifyLanguageChanging(model.code)
            }
            callback(error)
        }
    }
}

// MARK: - Currency
extension SettingsManager {
    
    /// Set App language
    public func setCurrencyModel(_ model: CurrencyModel, callback: @escaping (Error?) -> Void) {
        guard let oldSettingsModel = self.getSettings() else {
            let error = CustomError(title: "Settings not created", description: "Can't get language code, because settings for user not created", code: -1)
            callback(error)
            return
        }
        
        if oldSettingsModel.curencyModel.code == model.code {
            let error = CustomError(title: "Carrency settings are equal", description: "New settings for carrency equal to old settings", code: -1)
            callback(error)
            return
        }
        
        self.dao?.updateSettingCurrencyCode(Int64(model.code.rawValue), callback: callback)
    }
}

// MARK: - Local push
extension SettingsManager {
    
    public func enabledLocalPush(_ enabled: Bool, callback: @escaping (Error?) -> Void) {
        guard let oldSettingsModel = self.getSettings() else {
            let error = CustomError(title: "Settings not created", description: "Can't get language code, because settings for user not created", code: -1)
            callback(error)
            return
        }
        
        if oldSettingsModel.push == enabled {
            let error = CustomError(title: "Push settings are equal", description: "New settings for push equal to old settings", code: -1)
            callback(error)
            return
        }
        
        self.dao?.enabledLocalPush(enabled, callback: { (error) in
            if let error = error {
                callback(error)
            } else {
                let localPushManager = LocalPushManager.sharedInstance
                if enabled {
                    localPushManager.requestNotification(callback: callback)
                } else {
                    localPushManager.disableEveryDayLocalPush()
                }
                callback(nil)
            }
        })
    }
}
