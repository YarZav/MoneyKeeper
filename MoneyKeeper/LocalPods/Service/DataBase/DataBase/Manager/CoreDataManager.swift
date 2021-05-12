//
//  CoreDataManager.swift
//  DataBase
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

private struct Constants {
  static let name = "MoneyKeeper"
  static let `extension` = "momd"
  static let type = ".sqlite"
  static let fetchError = "There was an error creating or loading the application's saved data."
  static let initError = "Failed to initialize the application's saved data"
}

// MARK: - CoreDataManager
final class CoreDataManager {

  // MARK: - Singleton

  static let shared = CoreDataManager()

  // MARK: - Init

  private init() { }

  // MARK: - Core Data stack

  private lazy var applicationDocumentsDirectory: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count - 1]
  }()

  private lazy var managedObjectModel: NSManagedObjectModel? = {
    guard let modelURL = Bundle.main.url(forResource: Constants.name, withExtension: Constants.extension) else { return nil }
    return NSManagedObjectModel(contentsOf: modelURL)
  }()

  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    guard let managedObjectModel = managedObjectModel else { return nil }

    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let sqLitePathString = Constants.name + Constants.type
    let url = applicationDocumentsDirectory.appendingPathComponent(sqLitePathString)
    var failureReason = Constants.fetchError

    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    } catch {
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = Constants.initError as AnyObject
      dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
      dict[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
      abort()
    }
    return coordinator
  }()

  lazy var managedObjectContext: NSManagedObjectContext = {
    let coordinator = persistentStoreCoordinator
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
  }()
}

// MARK: - Publics

extension CoreDataManager {
  public func entityForName(entityName: String) -> NSEntityDescription {
    return NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.shared.managedObjectContext)!
  }

  public func saveContext(callback: @escaping (Error?) -> Void) {
    if managedObjectContext.hasChanges {
      do {
        try managedObjectContext.save()
        callback(nil)
      } catch {
        callback(error)
        abort()
      }
    } else {
      callback(nil)
    }
  }

  public func getFetchRequest(entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
    return NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  }

  public func getCoreDataModels<T>(entityName: String) -> [T]? {
    let fetchRequest = getFetchRequest(entityName: entityName)
    let results = try? managedObjectContext.fetch(fetchRequest) as? [T]
    return results
  }
}
