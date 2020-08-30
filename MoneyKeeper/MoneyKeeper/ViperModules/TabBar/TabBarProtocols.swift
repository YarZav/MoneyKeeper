//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - TabBarButtonType
enum TabBarButtonType: Int, CaseIterable {
    
    /// Cash flow navigation controller
    case cashFlow = 0
    
    /// Cash flow detail navigation controller
    case cashFlowDetail = 1
    
    /// Cards navigation controller
    case cards = 2
    
    /// Goals navigation controller
    case goals = 3
    
    /// Settings navigation controller
    case settings = 4
    
    /// Color for tabbar button
    var color: UIColor {
        switch self {
        case .cashFlow:         return .darkViolet
        case .cashFlowDetail:   return .plainGray
        case .cards:            return .blueGray
        case .goals:            return .plainPurple
        case .settings:         return .lightBlue
        }
    }
    
    /// Image for tabbar button
    var image: UIImage? {
        switch self {
        case .cashFlow:         return UIImage(named: "CashFlow")
        case .cashFlowDetail:   return UIImage(named: "CashFlowDetail")
        case .cards:            return UIImage(named: "Cards")
        case .goals:            return UIImage(named: "Goals")
        case .settings:         return UIImage(named: "Settings")
        }
    }
    
    /// Selected image for tabbar button
    var selectedImage: UIImage? {
        switch self {
        case .cashFlow:         return UIImage(named: "CashFlowBlack")
        case .cashFlowDetail:   return UIImage(named: "CashFlowDetailBlack")
        case .cards:            return UIImage(named: "CardsBlack")
        case .goals:            return UIImage(named: "GoalBlack")
        case .settings:         return UIImage(named: "SettingsBlack")
        }
    }
    
    /// Tag for tabbar button
    var tag: Int {
        switch self {
        case .cashFlow:         return 100
        case .cashFlowDetail:   return 101
        case .cards:            return 102
        case .goals:            return 103
        case .settings:         return 104
        }
    }
}

//Presenter -> View
protocol TabBarViewControllerProtocol: class {
    func createTabBarControllers(controlelrs: [UIViewController])
}

//View -> Presenter
protocol TabBarPresenterProtocol {
    func createTabBarControlelrs(for types: [TabBarButtonType])
}

//Presenter - Interactor
protocol TabBarInteractorProtocol { }

//Presenter - WireFrame
protocol TabBarWireFrameProtocol {
    func getNavigationController(by type: TabBarButtonType) -> UINavigationController
}
