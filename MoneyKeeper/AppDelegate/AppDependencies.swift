//
//  AppDependencies.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

// MAKR: - AppDependencies
class AppDependencies {

    /// Resolver
    var resolver: DIResolver

    //Init
    init() {
        let mapper = ModelMapper()
        let dao = DAO(mapper: mapper)
        
        let localPushManager = LocalPushManager.sharedInstance
        localPushManager.notificationCenter.delegate = localPushManager
        
        let settingsManager = SettingsManager.sharedInstance
        settingsManager.dao = dao
        
        self.resolver = DIResolver(dao: dao)
    }
}

// MARK: - Publics
extension AppDependencies {
    
    public func rootViewController() -> UIViewController {
        return self.resolver.createLaunchViewCotnroller()
    }
}
