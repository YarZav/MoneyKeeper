//
//  UserModel.swift
//  MoneyKeeper
//
//  Created by admin on 28.01.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

// MARK - UserModel
class UserModel {
  /// Device identifier
  public var deviceId: String

  /// User name
  public var userName: String?

  // Init
  init(deviceId: String) {
    self.deviceId = deviceId
  }
}
