//
//  CurrencyInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 13/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CurrencyInteractor
class CurrencyInteractor {
    
    private let settingsManager = SettingsManager.sharedInstance
    private let currencyModels = CurrencyFactory.models()
}

// MARK: - SingleSelectionTableInteractorProtocol
extension CurrencyInteractor: SingleSelectionTableInteractorProtocol {
    
    func getModels() -> [SingleSelectionModel] {
        if let settingsModel = settingsManager.getSettings() {
            self.currencyModels.first { $0.code == settingsModel.curencyModel.code }?.isOn = true
        }
        
        return self.currencyModels
    }
    
    func didSelectModel(at indexPath: IndexPath, callback: @escaping (Error?) -> Void) {
        let currencyModel = self.currencyModels[indexPath.row]
        self.settingsManager.setCurrencyModel(currencyModel, callback: callback)
    }
}
