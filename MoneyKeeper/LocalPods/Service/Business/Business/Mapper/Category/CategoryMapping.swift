//
//  CategoryMapper.swift
//  Business
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import DataBase

// MARK: - CategoryMapper
final class CategoryMapper {
  func map(_ categoryModel: CategoryModel?) -> CategoryDBModel? {
    guard let categoryModel = categoryModel else { return nil }
    let categoryDBModel = CategoryDBModel()
    categoryDBModel.identifier = categoryModel.identifier
//    categoryDBModel.imageName = model.imageName
//    categoryDBModel.title = model.title
    return categoryDBModel
  }

//  func map(_ categoryDBModel: CategoryDBModel?) -> CategoryModel? {
//    guard let categoryDBModel = categoryDBModel else { return nil }
//    return CategoryModel(identifier: categoryDBModel.identifier,
//                         imageName: categoryDBModel.imageName,
//                         title: categoryDBModel.title)
//  }
}
