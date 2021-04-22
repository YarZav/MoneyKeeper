//
//  CoreDataManager.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 27/01/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import CoreData

// MARK: - CoreDataManager
final class CoreDataManager {

  // MARK: - Singleton

  static let shared = CoreDataManager()

  // MARK: - Prviate property

  private let name: String = "MoneyKeeper"

  // MARK: - Init

  private init() { }

  // MARK: - Core Data stack

  lazy var applicationDocumentsDirectory: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count - 1]
  }()

  lazy var managedObjectModel: NSManagedObjectModel? = {
    if let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") {
      return NSManagedObjectModel(contentsOf: modelURL)
    }

    return nil
  }()

  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    guard let managedObjectModel = managedObjectModel else {
      return nil
    }

    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let sqLitePathString = name + ".sqlite"
    let url = applicationDocumentsDirectory.appendingPathComponent(sqLitePathString)
    var failureReason = "There was an error creating or loading the application's saved data."

    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    } catch {
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
      dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
      dict[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
      NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
      abort()
    }
    return coordinator
  }()

  lazy var managedObjectContext: NSManagedObjectContext = {
    let coordinator = persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
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
    }
  }

  public func getFetchRequest(entityName: String) -> NSFetchRequest<NSFetchRequestResult> {
    return NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
  }

  public func getCoreDataModels<T>(entityName: String) -> [T]? {
    do {
      let fetchRequest = getFetchRequest(entityName: entityName)
      let results = try managedObjectContext.fetch(fetchRequest) as? [T]
      return results
    } catch {
      return nil
    }
  }
}
