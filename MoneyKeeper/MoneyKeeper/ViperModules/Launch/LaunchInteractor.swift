//
//  LaunchInteractor.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - LaunchInteractor
class LaunchInteractor {
    
    private let dao: UserDAOProtocol
    
    init(dao: UserDAOProtocol) {
        self.dao = dao
    }
}

// MARK: - LaunchInteractorProtocol
extension LaunchInteractor: LaunchInteractorProtocol {
    func saveUser(for deviceId: String?, callback: @escaping (Error?) -> Void) {
//        dao.saveModel(for: deviceId, callback: callback)
    }
}
