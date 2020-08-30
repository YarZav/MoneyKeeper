//
//  AppDelegate.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17.09.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
  var window: UIWindow?
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let appDependencies = AppDependencies()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = appDependencies.rootViewController()
    window?.makeKeyAndVisible()
    return true
  }
}

