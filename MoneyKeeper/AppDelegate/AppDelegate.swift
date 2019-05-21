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

    //Properties
    var window: UIWindow?
    var appDependencies: AppDependencies! = nil
    
    //Life cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appDependencies = AppDependencies()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.appDependencies.rootViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
}

