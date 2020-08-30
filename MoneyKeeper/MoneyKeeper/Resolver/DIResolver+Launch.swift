//
//  DIResolver+Launch.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 16/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - LaunchDIResolver
extension DIResolver {
    
    // TabBar
    func createLaunchViewCotnroller() -> UIViewController {
        let view = LaunchViewController()
        let interactor = LaunchInteractor(dao: userDAO)
        let wireFrame = LaunchWireFrame(resolver: self)
        let presenter = LaunchPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        
        return view
    }
}
