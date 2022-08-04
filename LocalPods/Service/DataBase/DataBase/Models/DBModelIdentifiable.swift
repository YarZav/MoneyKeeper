//
//  DBModelIdentifiable.swift
//  DataBase
//
//  Created by y.zavyalov on 22.04.2021.
//

protocol DBModelIdentifiable {

  /// DataBase model identifier
  var identifier: UUID { get set }

  /// DataBase name
  static var entityName: String { get }

}
