//
//  AppDelegate.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 17.09.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import FirebaseCore

@UIApplicationMain
final class AppDelegate: UIResponder {

  var window: UIWindow?

  private let coordinatorFlow: AppCoordinatorFlowProtocol = AppCoordinatorFlow()
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setUpAnalytics()
    setUpWindow()
    return true
  }
}

// MARK: - Private

private extension AppDelegate {

  func setUpAnalytics() {
    FirebaseApp.configure()
  }

  func setUpWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = coordinatorFlow.rootViewController
    window?.makeKeyAndVisible()
  }
}
