//
//  AppDependencies.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MAKR: - AppDependencies
class AppDependencies {

    //Properties
    var resolver: DIResolver

    //Init
    init() {
        self.resolver = DIResolver()
        self.resolver.dao.createUserAccount()
    }
}

// MARK: - Publics
extension AppDependencies {
    
    public func rootViewController() -> UIViewController {
        return self.resolver.createTabBarViewCotnroller()
    }
}
