//  
//  SettingsInteractor.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MAARK: - SettingsInteractor
class SettingsInteractor {
    
    private let settingsManager = SettingsManager.sharedInstance
    private let dao: DAO
    
    init(dao: DAO) {
        self.dao = dao
    }
}

// MARK: - SettingsInteractorProtocol
extension SettingsInteractor: SettingsInteractorProtocol {
    
    func enabledlocalPush(_ enabled: Bool, callback: @escaping (Error?) -> Void) {
        self.settingsManager.enabledLocalPush(enabled, callback: callback)
    }
    
    func clearUserData(callback: @escaping (Error?) -> Void) {
        self.dao.deleteUserCoreDataInfo(callback: callback)
    }
}
