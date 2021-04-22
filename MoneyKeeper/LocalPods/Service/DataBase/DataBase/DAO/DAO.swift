//
//  DAO.swift
//  DataBase
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

protocol DAO {
  associatedtype DataBaseModel

  func getAll() -> [DataBaseModel]?
  func get(by identifier: String) -> DataBaseModel?

  func save(_ models: [DataBaseModel], callback: @escaping (Error?) -> Void)
  func save(_ model: DataBaseModel, callback: @escaping (Error?) -> Void)

  func deleteAll(callback: @escaping (Error?) -> Void)
  func delete(by identifier: String, callback: @escaping (Error?) -> Void)
}
