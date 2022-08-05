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
        .init(identifier: UUID(), title: "Alcohol", imageName: "Alcohol"),
        .init(identifier: UUID(), title: "Animals", imageName: "Animals"),
        .init(identifier: UUID(), title: "AppStore", imageName: "AppStore"),
        .init(identifier: UUID(), title: "Automobile", imageName: "Automobile"),
        .init(identifier: UUID(), title: "Baby", imageName: "Baby"),
        .init(identifier: UUID(), title: "Bike", imageName: "Bike"),
        .init(identifier: UUID(), title: "Books", imageName: "Books"),
        .init(identifier: UUID(), title: "Business", imageName: "Business"),
        .init(identifier: UUID(), title: "Clothes", imageName: "Clothes"),
        .init(identifier: UUID(), title: "Coffee", imageName: "Coffee"),
        .init(identifier: UUID(), title: "Education", imageName: "Education"),
        .init(identifier: UUID(), title: "Electronics", imageName: "Electronics"),
        .init(identifier: UUID(), title: "Furniture", imageName: "Furniture"),
        .init(identifier: UUID(), title: "Gift", imageName: "Gift"),
        .init(identifier: UUID(), title: "Gym", imageName: "Gym"),
        .init(identifier: UUID(), title: "House", imageName: "House"),
        .init(identifier: UUID(), title: "Internet", imageName: "Internet"),
        .init(identifier: UUID(), title: "Medicine", imageName: "Medicine"),
        .init(identifier: UUID(), title: "Mobile", imageName: "Mobile"),
        .init(identifier: UUID(), title: "Petrol Station", imageName: "PetrolStation"),
        .init(identifier: UUID(), title: "Products", imageName: "Products"),
        .init(identifier: UUID(), title: "Relaxation", imageName: "Relaxation"),
        .init(identifier: UUID(), title: "Transit", imageName: "Transit"),
        .init(identifier: UUID(), title: "TV", imageName: "TV"),
      ]
    }
}
