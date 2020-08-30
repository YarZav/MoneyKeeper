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
  var resolver: DIResolver

  init() {
    let localPushManager = LocalPushManager.sharedInstance
    localPushManager.notificationCenter.delegate = localPushManager
    resolver = DIResolver()
  }
}

// MARK: - Publics
extension AppDependencies {
  public func rootViewController() -> UIViewController {
    return resolver.createLaunchViewCotnroller()
  }
}
