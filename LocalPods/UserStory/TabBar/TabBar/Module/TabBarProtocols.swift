//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// Presenter -> View
protocol TabBarViewProtocol: AnyObject {

  func tabBarControllers(_ viewControllers: [UINavigationController])

}

// View -> Presenter
protocol TabBarPresenterProtocol {

  func viewWillAppear()

}

// Presenter - WireFrame
protocol TabBarWireFrameProtocol {

    func cashNavigationController() -> UINavigationController

}
