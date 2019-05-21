//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

//Presenter -> View
public protocol TabBarViewControllerProtocol: class {
    func createTabBarControllers(controlelrs: [UIViewController])
}

//View -> Presenter
public protocol TabBarPresenterProtocol {
    func createTabBarControlelrs()
}

//Presenter - Interactor
public protocol TabBarInteractorProtocol { }

//Presenter - WireFrame
public protocol TabBarWireFrameProtocol {
    func getCashFlowNavigationController() -> UINavigationController
    func getCashFlowDetailNavigationController() -> UINavigationController
    func getCardNavigationController() -> UINavigationController
    func getGoalNavigationController() -> UINavigationController
    func getSettingNavigationController() -> UINavigationController
}
