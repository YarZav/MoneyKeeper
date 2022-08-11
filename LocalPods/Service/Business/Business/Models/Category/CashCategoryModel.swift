//
//  CashCategoryModel.swift
//  DataBase
//
//  Created by Yaroslav Zavyalov on 8/4/22.
//

public struct CashCategoryModel {

  /// identifier of model
  public let identifier: UUID

  /// Title of model
  public let title: String

  /// Name of image model
  public let imageName: String

}

// MARK: - Default categories

public extension CashCategoryModel {
    static var categories: [CashCategoryModel] {
      [
        .init(
            identifier: UUID(),
            title: "AlcoholKey".localized(),
            imageName: "Alcohol"
        ),
        .init(
            identifier: UUID(),
            title: "AnimalsKey".localized(),
            imageName: "Animals"
        ),
        .init(
            identifier: UUID(),
            title: "AppStoreKey".localized(),
            imageName: "AppStore"
        ),
        .init(
            identifier: UUID(),
            title: "AutomobileKey".localized(),
            imageName: "Automobile"
        ),
        .init(
            identifier: UUID(),
            title: "BabyKey".localized(),
            imageName: "Baby"
        ),
        .init(
            identifier: UUID(),
            title: "BikeKey".localized(),
            imageName: "Bike"
        ),
        .init(
            identifier: UUID(),
            title: "BooksKey".localized(),
            imageName: "Books"
        ),
        .init(
            identifier: UUID(),
            title: "BusinessKey".localized(),
            imageName: "Business"
        ),
        .init(
            identifier: UUID(),
            title: "ClothesKey".localized(),
            imageName: "Clothes"
        ),
        .init(
            identifier: UUID(),
            title: "CoffeeKey".localized(),
            imageName: "Coffee"
        ),
        .init(
            identifier: UUID(),
            title: "EducationKey".localized(),
            imageName: "Education"
        ),
        .init(
            identifier: UUID(),
            title: "ElectronicsKey".localized(),
            imageName: "Electronics"
        ),
        .init(
            identifier: UUID(),
            title: "FurnitureKey".localized(),
            imageName: "Furniture"
        ),
        .init(
            identifier: UUID(),
            title: "GiftKey".localized(),
            imageName: "Gift"
        ),
        .init(
            identifier: UUID(),
            title: "GymKey".localized(),
            imageName: "Gym"
        ),
        .init(
            identifier: UUID(),
            title: "HouseKey".localized(),
            imageName: "House"
        ),
        .init(
            identifier: UUID(),
            title: "InternetKey".localized(),
            imageName: "Internet"
        ),
        .init(
            identifier: UUID(),
            title: "MedicineKey".localized(),
            imageName: "Medicine"
        ),
        .init(
            identifier: UUID(),
            title: "MobileKey".localized(),
            imageName: "Mobile"
        ),
        .init(
            identifier: UUID(),
            title: "PetrolStationKey".localized(),
            imageName: "PetrolStation"
        ),
        .init(
            identifier: UUID(),
            title: "ProductsKey".localized(),
            imageName: "Products"
        ),
        .init(
            identifier: UUID(),
            title: "RelaxationKey".localized(),
            imageName: "Relaxation"
        ),
        .init(
            identifier: UUID(),
            title: "TransitKey".localized(),
            imageName: "Transit"
        ),
        .init(
            identifier: UUID(),
            title: "TVKey".localized(),
            imageName: "TV"
        ),
      ]
    }
}
