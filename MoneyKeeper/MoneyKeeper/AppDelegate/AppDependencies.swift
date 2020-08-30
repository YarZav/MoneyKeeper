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
        let localPushManager = LocalPushManager.sharedInstance
        localPushManager.notificationCenter.delegate = localPushManager
                
        self.resolver = DIResolver()
    }
}

// MARK: - Publics
extension AppDependencies {
    
    public func rootViewController() -> UIViewController {
        return self.resolver.createLaunchViewCotnroller()
    }
}
