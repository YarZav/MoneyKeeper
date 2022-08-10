//
//  DAO.swift
//  DataBase
//
//  Created by admin on 03/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public protocol DAOProtocol {

  associatedtype DataBaseModel
  associatedtype BusinessModel

  func getAll() -> [BusinessModel]?
  func get(by identifier: UUID) -> BusinessModel?

  func saveAll(_ models: [BusinessModel], callback: @escaping (Error?) -> Void)
  func save(_ model: BusinessModel, callback: @escaping (Error?) -> Void)

  func update(_ model: BusinessModel, callback: @escaping (Error?) -> Void)

  func deleteAll(callback: @escaping (Error?) -> Void)
  func delete(by identifier: UUID, callback: @escaping (Error?) -> Void)

}
