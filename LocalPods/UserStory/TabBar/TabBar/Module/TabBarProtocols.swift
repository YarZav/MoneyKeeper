//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// Presenter -> View
protocol TabBarView: AnyObject {

  func tabBarControllers(_ controllers: [UINavigationController])

}

// View -> Presenter
protocol TabBarPresenter {

  func viewWillAppear()

}

// Presenter - WireFrame
protocol TabBarWireFrame {

    func cashNavigationController() -> UINavigationController

}
