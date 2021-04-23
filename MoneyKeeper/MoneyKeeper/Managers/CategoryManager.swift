//
//  CategoryManager.swift
//  MoneyKeeper
//
//  Created by admin on 10/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

/// Thread safe manager to get and set cash flow models
final class CategoryManager {
  // Property
  private let isolationQueue = DispatchQueue(label: "com.MoneyKeeper.Category", qos: .userInteractive, attributes: .concurrent)
//  private let dao: CategoryDAOProtocol

  // Init
//  init(dao: CategoryDAOProtocol) {
//    self.dao = dao
//  }
}

// MARK: - Publics
extension CategoryManager {
  /// Thread safe add category models to CoreData
  public func saveModel(_ model: CategoryModel, callback: @escaping (Error?) -> Void) {
//        guard let categoryCoreDataModel = self.dao.mapper.categoryMapping(model) else {
//            let error = CustomError(title: "Category model map error", description: "Unavailable to map business model to coredata model", code: -1)
//            callback(error)
//            return
//        }
//
//        self.isolationQueue.async(flags: .barrier) {
//            self.dao.saveCategoryCoreDataModel(categoryCoreDataModel, callback: callback)
//        }
  }

  /// Thread safe delete category models from CoreData
  public func deleteModel(_ model: CategoryModel, callback: @escaping (Error?) -> Void) {
//        self.isolationQueue.async(flags: .barrier) {
//            self.dao.deleteCategoryCoreDataModelBy(id: model.id, callback: callback)
//        }
  }

  /// Thread safe get category models from CoreData
  public func getModels() -> [CategoryModel]? {
//        var categoryCoreDataModels: [CategoryCoreDataModel]?
//        self.isolationQueue.sync {
//            categoryCoreDataModels = self.dao.getCategoryCoreDataModels()
//        }
//        return self.dao.mapper.categoryMapping(categoryCoreDataModels)
    return nil
  }
}

// MARK: - Default values
extension CategoryManager {
  /// Get default categories for user
  static public func getDefaultItems() -> [(title: String, icon: String)] {
    let products    = (title: "Products", icon: "Products")
    let transport   = (title: "Transit", icon: "Transit")
    let clothes     = (title: "Сlothes", icon: "Clothes")
    let sport       = (title: "Sport", icon: "Sport")
    let automobile  = (title: "Automobile", icon: "Automobile")
    let house       = (title: "Home", icon: "House")
    let relaxation  = (title: "Relax", icon: "Relaxation")
    let mobile      = (title: "Mobile", icon: "Mobile")
    let internet    = (title: "Internet", icon: "Internet")
    let medicine    = (title: "Medicine", icon: "Medicine")
    let education   = (title: "Education", icon: "Education")
    let business    = (title: "Business", icon: "Business")
    let electronics = (title: "Devices", icon: "Electronics")
    let book        = (title: "Books", icon: "Books")

    return [products, transport, clothes, sport, automobile, house, relaxation, mobile, internet, medicine, education, business, electronics, book]
  }
    
  /// Get available category images
  static public func getDefaultImageNames() -> [String] {
    return ["Animals",
      "AppStore",
      "Automobile",
      "Baby",
      "Beer",
      "Bike",
      "Books",
      "Business",
      "Chat",
      "Clothes",
      "Coffee",
      "Education",
      "Electronics",
      "GameBoy",
      "Gift",
      "Gym",
      "Furniture",
      "House",
      "Internet",
      "Medicine",
      "Mobile",
      "PetrolStation",
      "Photo",
      "Products",
      "Relaxation",
      "Sport",
      "Transit",
      "TV"
    ]
  }
}
