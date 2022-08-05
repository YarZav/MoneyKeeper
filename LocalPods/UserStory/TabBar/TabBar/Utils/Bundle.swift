//  
//  Bundle.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

import Foundation

extension Bundle {

  private static var tabBarBundleCocoapods: Bundle = Bundle(
    identifier: "org.cocoapods.TabBar"
  ) ?? .main

  static var tabBarBundle: Bundle = Bundle(
    url: tabBarBundleCocoapods.bundleURL.appendingPathComponent("TabBar.bundle")
  ) ?? tabBarBundleCocoapods

}
