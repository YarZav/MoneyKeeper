//  
//  Bundle.swift
//  Pods
//
//  Created by ZOLOTAREV Sergey on 02.02.2021.
//

import Foundation

extension Bundle {

  private static var designSystemBundleCocoapods: Bundle = Bundle(
    identifier: "org.cocoapods.DesignSystem"
  ) ?? .main

  static var designSystemBarBundle: Bundle = Bundle(
    url: designSystemBundleCocoapods.bundleURL.appendingPathComponent("DesignSystem.bundle")
  ) ?? designSystemBundleCocoapods

}
