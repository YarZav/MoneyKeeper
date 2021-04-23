//
//  CardModel.swift
//  Business
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import AVFoundation

// MARK: - CardModel
public struct CardModel {
  /// identifier of model
  public let identifier: String

  /// Date of add
  public let date: Date
  
  /// Bar code value
  public let code: String
  
  /// Bar code type
  public let type: AVMetadataObject.ObjectType
  
  /// Name for bar code
  public let title: String
}
