//
//  LanguageInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - LanguageInteractor
class LanguageInteractor {
    private let languageModels = LanguageFactory.models()
}

// MARK: - SingleSelectionTableInteractorProtocol
extension LanguageInteractor: SingleSelectionTableInteractorProtocol {
    
    func getModels() -> [SingleSelectionModel] {
//        if let settingsModel = self.settingsManager.getSettings() {
//            self.languageModels.first { $0.code == settingsModel.languageModel.code }?.isOn = true
//        }
//
//        return self.languageModels
        return []
    }
    
    func didSelectModel(at indexPath: IndexPath, callback: @escaping (Error?) -> Void) {
//        let languageModel = self.languageModels[indexPath.row]
//        self.settingsManager.setLanguageModel(languageModel, callback: callback)
    }
}
