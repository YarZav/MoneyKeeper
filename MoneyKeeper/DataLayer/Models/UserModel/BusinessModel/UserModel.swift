//
//  UserModel.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK - UserModel
class UserModel {
    
    /// Device identifier
    public var deviceId: String
    
    /// User name
    public var userName: String?
    
    //FIXME: Mb this is do not need here OR add service models
    /// Cash transactions
    public var cashFlows: [CashFlowModel]?
    
    // Init
    init(deviceId: String) {
        self.deviceId = deviceId
    }
}
