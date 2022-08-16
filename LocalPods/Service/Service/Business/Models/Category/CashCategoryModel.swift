//
//  CashCategoryModel.swift
//  DataBase
//
//  Created by Yaroslav Zavyalov on 8/4/22.
//

public struct CashCategoryModel {

  // MARK: - Public property

  /// identifier of model
  public let identifier: UUID

  /// Title of model
  public let title: String

  /// Name of image model
  public let imageName: String

  // MARK: - Init

  public init(identifier: UUID, title: String, imageName: String) {
    self.identifier = identifier
    self.title = title
    self.imageName = imageName
  }

}
