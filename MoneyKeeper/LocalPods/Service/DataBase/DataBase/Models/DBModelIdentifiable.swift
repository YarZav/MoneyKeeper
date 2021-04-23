//
//  DBModelIdentifiable.swift
//  DataBase
//
//  Created by y.zavyalov on 22.04.2021.
//

protocol DBModelIdentifiable {
  var identifier: String { get set }
  static var entityName: String { get }
}
