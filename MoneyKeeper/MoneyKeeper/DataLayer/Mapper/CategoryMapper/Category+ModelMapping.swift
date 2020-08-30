//
//  Category+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

// MARK: - CategoryModelMapper
class CategoryModelMapper {
  func map(_ model: CategoryModel?) -> CategoryCoreDataModel? {
    guard let model = model else { return nil }
    let categoryCoreDataModel = CategoryCoreDataModel()
    categoryCoreDataModel.identifier = model.id
    categoryCoreDataModel.imageName = model.imageName
    categoryCoreDataModel.title = model.title
    return categoryCoreDataModel
  }
      
  func map(_ model: CategoryCoreDataModel?) -> CategoryModel? {
    guard let model = model else { return nil }
    let categoryModel = CategoryModel(title: model.title, imageName: model.imageName)
    categoryModel.id = model.identifier
    return categoryModel
  }
}
