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
            title: NSLocalizedString("Alcohol", comment: "The name of the alcohol group"),
            imageName: "Alcohol"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Animals", comment: "The name of the animals group"),
            imageName: "Animals"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("AppStore", comment: "The name of the App Store group"),
            imageName: "AppStore"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Automobile", comment: "The name of the automobile group"),
            imageName: "Automobile"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Baby", comment: "The name of the automobile group"),
            imageName: "Baby"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Bike", comment: "The name of the automobile group"),
            imageName: "Bike"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Books", comment: "The name of the automobile group"),
            imageName: "Books"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Business", comment: "The name of the automobile group"),
            imageName: "Business"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Clothes", comment: "The name of the automobile group"),
            imageName: "Clothes"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Coffee", comment: "The name of the automobile group"),
            imageName: "Coffee"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Education", comment: "The name of the automobile group"),
            imageName: "Education"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Electronics", comment: "The name of the automobile group"),
            imageName: "Electronics"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Furniture", comment: "The name of the automobile group"),
            imageName: "Furniture"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Gift", comment: "The name of the automobile group"),
            imageName: "Gift"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Gym", comment: "The name of the automobile group"),
            imageName: "Gym"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("House", comment: "The name of the automobile group"),
            imageName: "House"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Internet", comment: "The name of the automobile group"),
            imageName: "Internet"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Medicine", comment: "The name of the automobile group"),
            imageName: "Medicine"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Mobile", comment: "The name of the automobile group"),
            imageName: "Mobile"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("PetrolStation", comment: "The name of the automobile group"),
            imageName: "PetrolStation"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Products", comment: "The name of the automobile group"),
            imageName: "Products"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Relaxation", comment: "The name of the automobile group"),
            imageName: "Relaxation"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("Transit", comment: "The name of the automobile group"),
            imageName: "Transit"
        ),
        .init(
            identifier: UUID(),
            title: NSLocalizedString("TV", comment: "The name of the automobile group"),
            imageName: "TV"
        ),
      ]
    }
}
