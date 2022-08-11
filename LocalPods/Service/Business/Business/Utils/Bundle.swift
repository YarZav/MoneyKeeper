//  
//  Bundle.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

import Foundation

extension Bundle {

  private static var businessBundleCocoapods: Bundle = Bundle(
    identifier: "org.cocoapods.Business"
  ) ?? .main

  static var businessBarBundle: Bundle = Bundle(
    url: businessBundleCocoapods.bundleURL.appendingPathComponent("Business.bundle")
  ) ?? businessBundleCocoapods

}
