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
    
    private let dao: DAO
    
    init(dao: DAO) {
        self.dao = dao
    }
}

// MARK: - LaunchInteractorProtocol
extension LaunchInteractor: LaunchInteractorProtocol {
    
    func createUserAccount(callback: @escaping (Error?) -> Void) {
        self.dao.createUserAccount(callback: callback)
    }
}
