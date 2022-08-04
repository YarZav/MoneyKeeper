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

  var rootViewController: UIViewController? { get set }
  func tabBarControllers(_ controllers: [UINavigationController])

}

// View -> Presenter
protocol TabBarPresenter {

  func viewWillAppear(rootViewController: UIViewController)

}

// Presenter - WireFrame
protocol TabBarWireFrame {

  func navigationController(with rootViewController: UIViewController, type: TabBarButtonType) -> UINavigationController

}
