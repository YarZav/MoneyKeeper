//  
//  Bundle.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

import Foundation

extension Bundle {

  private static var serviceBundleCocoapods: Bundle = Bundle(
    identifier: "org.cocoapods.Service"
  ) ?? .main

  static var serviceBundle: Bundle = Bundle(
    url: serviceBundleCocoapods.bundleURL.appendingPathComponent("Service.bundle")
  ) ?? serviceBundleCocoapods

}
