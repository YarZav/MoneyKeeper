//
//  AppDelegate.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17.09.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import TabBar
import DI
import Cash

@UIApplicationMain
final class AppDelegate: UIResponder {

  var window: UIWindow?

  private let swinjectAssembly = SwinjectAssembly(with: [TabBarAssembly(), CashAssembly()])

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = swinjectAssembly.assembler.tabBarViewController()
    window?.makeKeyAndVisible()
    return true
  }
}
