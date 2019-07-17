//
//  CategoryModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 12.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

//MARK: - CategoryModel
class CategoryModel {
    
    /// Identifier of model
    var id: String = UUID().uuidString
    
    /// Image name for category model
    var imageName: String
    
    /// Name of category
    var title: String
    
    //Init
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

// MARK: - Publics
extension CategoryModel {
    
    //Default models
    static public func defaultModels() -> [CategoryModel] {
        var models = [CategoryModel]()
        for defaultCategory in CategoryManager.getDefaultItems() {
            let model = CategoryModel(title: defaultCategory.title, imageName: defaultCategory.icon)
            models.append(model)
        }
        
        return models
    }
}
