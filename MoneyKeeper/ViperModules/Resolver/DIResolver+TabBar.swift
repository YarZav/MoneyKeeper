//
//  DIResolver+TabBar.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarDIResolver
extension DIResolver {

    // TabBar
    func createTabBarViewCotnroller() -> UIViewController {
        let view = TabBarViewController()
        let interactor = TabBarInteractor()
        let wireFrame = TabBarWireFrame(resolver: self)
        let presenter = TabBarPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        
        return view
    }
}
