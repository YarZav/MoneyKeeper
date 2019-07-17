//
//  Category+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CategoryModelMapper
extension ModelMapper {
    
    //Model -> CoreData
    func categoryMapping(_ model: CategoryModel?) -> CategoryCoreDataModel? {
        guard let model = model else { return nil }
        
        let categoryCoreDataModel = CategoryCoreDataModel()
        categoryCoreDataModel.identifier = model.id
        categoryCoreDataModel.imageName = model.imageName
        categoryCoreDataModel.title = model.title
        
        return categoryCoreDataModel
    }
    
    //[Model] -> [CoreData]
    func categoryMapping(_ models: [CategoryModel]?) -> [CategoryCoreDataModel]? {
        return models?.compactMap({ self.categoryMapping($0) })
    }
    
    //CoreData -> Model
    func categoryMapping(_ model: CategoryCoreDataModel?) -> CategoryModel? {
        guard let model = model else { return nil }
        
        let categoryModel = CategoryModel(title: model.title, imageName: model.imageName)
        categoryModel.id = model.identifier
        
        return categoryModel
    }
    
    //[CoreData] -> [Model]
    func categoryMapping(_ models: [CategoryCoreDataModel]?) -> [CategoryModel]? {
        return models?.compactMap({ self.categoryMapping($0) })
    }
}
