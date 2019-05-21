//
//  ServiceModel.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 12.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import Foundation

//MARK: - ServiceModel
class ServiceModel {
    
    /// Identifier of model
    var id: String = UUID().uuidString
    
    /// Image name for service model
    var imageName: String
    
    /// Name of service
    var title: String
    
    //Init
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

// MARK: - Publics
extension ServiceModel {
    
    //Default models
    static public func defaultModels() -> [ServiceModel] {
        var models = [ServiceModel]()
        for defaultService in ServiceModel.getDefaultItems() {
            let model = ServiceModel(title: defaultService.title, imageName: defaultService.icon)
            models.append(model)
        }
        
        return models
    }
}

// MARK: - Privates
extension ServiceModel {
    
    static private func getDefaultItems() -> [(title: String, icon: String)] {
        let products    = (title: "Продукты", icon: "Products")
        let transport   = (title: "Проезд", icon: "Transit")
        let clothes     = (title: "Одежда", icon: "Clothes")
        let sport       = (title: "Спорт", icon: "Sport")
        let automobile  = (title: "Авто", icon: "Automobile")
        let house       = (title: "Дом", icon: "House")
        let relaxation  = (title: "Отдых", icon: "Relaxation")
        let mobile      = (title: "Мобильная связь", icon: "Mobile")
        let internet    = (title: "Интернет", icon: "Internet")
        let medicine    = (title: "Медицина", icon: "Medicine")
        let education   = (title: "Образование", icon: "Education")
        let business    = (title: "Бизнес", icon: "Business")
        let electronics = (title: "Электроника", icon: "Electronics")
        let book        = (title: "Книги", icon: "Books")
        
        return [products, transport, clothes, sport, automobile, house, relaxation, mobile, internet, medicine, education, business, electronics, book]
    }
}
