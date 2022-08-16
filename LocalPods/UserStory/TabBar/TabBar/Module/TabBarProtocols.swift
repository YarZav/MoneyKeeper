//
//  TabBarProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 04.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

// INPUT & OUTPUT
public protocol TabBarProtocol: TabBarInputProtocol & TabBarOutputProtocol { }

// INPUT
public protocol TabBarInputProtocol {

  var cashViewController: UIViewController? { get set }
  var cashDetailViewController: UIViewController? { get set }

}

// OUTPUT
public protocol TabBarOutputProtocol {

  var cashViewController: UIViewController? { get set }

}

// View
public protocol TabBarViewProtocol { }
