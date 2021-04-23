//
//  CategoryModel.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 12.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

//MARK: - CategoryModel
public struct CategoryModel {
  /// Identifier of model
  public let identifier: String

  /// Image name for category model
  public let imageName: String

  /// Name of category
  public let title: String
}

// MARK: - Publics
//extension CategoryModel {
//  //Default models
//  static public func defaultModels() -> [CategoryModel] {
//    var models = [CategoryModel]()
//    for defaultCategory in CategoryManager.getDefaultItems() {
//      let model = CategoryModel(title: defaultCategory.title, imageName: defaultCategory.icon)
//      models.append(model)
//    }
//    return models
//  }
//}
