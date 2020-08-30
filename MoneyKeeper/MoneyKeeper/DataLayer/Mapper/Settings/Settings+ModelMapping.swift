//
//  Settings+ModelMapping.swift
//  MoneyKeeper
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

// MARK: - SettingsModelMapper
class SettingsModelMapper {
    func map(_ model: SettingsModel?) -> SettingsCoreDataModel? {
        guard let model = model else { return nil }
        
        let settingsCoreDataModel = SettingsCoreDataModel()
        settingsCoreDataModel.languageCode = Int64(model.languageModel.code.rawValue)
        settingsCoreDataModel.currencyCode = Int64(model.curencyModel.code.rawValue)
        settingsCoreDataModel.push = model.push
        settingsCoreDataModel.iCloud = model.iCloud
        settingsCoreDataModel.pincode = model.pincode
        settingsCoreDataModel.touchID = model.touchID
        settingsCoreDataModel.showHint = model.showHint
        
        return settingsCoreDataModel
    }
    
    func map(_ model: SettingsCoreDataModel?) -> SettingsModel? {
        guard let model = model else { return nil }
        guard let languageCode = LanguageCode(rawValue: Int(model.languageCode)) else { return nil }
        guard let currencyCode = CurrencyCode(rawValue: Int(model.currencyCode)) else { return nil }

        let languageModel = LanguageModel(isOn: true, code: languageCode)
        let currencyModel = CurrencyModel(isOn: true, code: currencyCode)
        let settingsModel = SettingsModel(languageModel: languageModel, curencyModel: currencyModel)
        
        settingsModel.push = model.push
        settingsModel.iCloud = model.iCloud
        settingsModel.pincode = model.pincode
        settingsModel.touchID = model.touchID
        settingsModel.showHint = model.showHint
        
        return settingsModel
    }
}
