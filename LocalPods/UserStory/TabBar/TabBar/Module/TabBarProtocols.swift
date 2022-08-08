//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// INPUT & OUTPUT
public protocol TabBarProtocol: TabBarInputProtocol & TabBarOutputProtocol { }

// INPUT
public protocol TabBarInputProtocol {

  var cashViewController: UIViewController? { get set }

}

// OUTPUT
public protocol TabBarOutputProtocol {

  var cashViewController: UIViewController? { get set }

}

// VIEW
protocol TabBarViewProtocol: AnyObject { }
