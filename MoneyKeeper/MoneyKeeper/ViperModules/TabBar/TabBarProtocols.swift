//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

//Presenter -> View
protocol TabBarView: AnyObject {
  func tabBarControllers(_ controlelrs: [UIViewController])
}

//View -> Presenter
protocol TabBarPresenter {
  func viewDidLoad()
}

//Presenter - Interactor
protocol TabBarInteractor { }

//Presenter - WireFrame
protocol TabBarWireFrame {
  func getNavigationController(by type: TabBarButtonType) -> UINavigationController
}
