//  
//  Bundle.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

import Foundation

extension Bundle {

  private static var cashBundleCocoapods: Bundle = Bundle(
    identifier: "org.cocoapods.Cash"
  ) ?? .main

  public static var cashBundle: Bundle = Bundle(
    url: cashBundleCocoapods.bundleURL.appendingPathComponent("Cash.bundle")
  ) ?? cashBundleCocoapods

}
