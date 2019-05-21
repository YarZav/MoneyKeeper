//
//  Service+ModelMapping.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - ServiceMapperProtocol
protocol ServiceMapperProtocol {
    func serviceMapping(_ model: ServiceModel?) -> ServiceCoreDataModel?
    func serviceMapping(_ model: ServiceCoreDataModel?) -> ServiceModel?
}

// MARK: - ServiceMapperProtocol
extension ModelMapper: ServiceMapperProtocol {
    
    //Model -> CoreData
    func serviceMapping(_ model: ServiceModel?) -> ServiceCoreDataModel? {
        if let model = model {
            let serviceCoreDataModel = ServiceCoreDataModel()
            serviceCoreDataModel.identifier = model.id
            serviceCoreDataModel.imageName = model.imageName
            serviceCoreDataModel.title = model.title

            return serviceCoreDataModel
        }
        
        return nil
    }
    
    //CoreData -> Model
    func serviceMapping(_ model: ServiceCoreDataModel?) -> ServiceModel? {
        if let model = model {
            let serviceModel = ServiceModel(title: model.title, imageName: model.imageName)
            serviceModel.id = model.identifier
            
            return serviceModel
        }
        
        return nil
    }
}
