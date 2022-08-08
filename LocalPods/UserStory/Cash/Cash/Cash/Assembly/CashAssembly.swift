//
//  CashAssembly.swift
//  Business
//
//  Created by 19205313 on 31.05.2021.
//

import Swinject
import Business
import DataBase

public final class CashAssembly {

  public init() { }

}

// MARK: - Assembly

extension CashAssembly: Assembly {

  public func assemble(container: Container) {
    registerCashDAO(container: container)

    registerCashView(container: container)
    registerCashInteractor(container: container)
    registerCashPresenter(container: container)

    registerCashCategoryView(container: container)
    registerCashCategoryInteractor(container: container)
    registerCashCategoryPresenter(container: container)
  }

}

// MARK: - Cash DAO

private extension CashAssembly {

  func registerCashDAO(container: Container) {
    container.register(CashDAO.self) { _ in
      return CashDAO(mapper: CashMapper(), coreDataManager: CoreDataManager.shared)
    }.inObjectScope(.container)
  }

}

// MARK: - Cash

private extension CashAssembly {

  func registerCashView(container: Container) {
    container.register(CashViewProtocol.self) {
      guard let presenter = $0.resolve(CashPresenterProtocol.self) else {
        fatalError("CashPresenter is not in container")
      }
      return CashViewController(presenter: presenter)
    }.inObjectScope(.container)
  }

  func registerCashInteractor(container: Container) {
    container.register(CashInteractorProtocol.self) {
      guard let cashDAO = $0.resolve(CashDAO.self) else {
        fatalError("CashDAO is not in container")
      }
      return CashInteractor(cashDAO: cashDAO)
    }.inObjectScope(.container)
  }

  func registerCashPresenter(container: Container) {
    container.register(CashPresenterProtocol.self) {
      guard let interactor = $0.resolve(CashInteractorProtocol.self) else {
        fatalError("CashInteractor is not in container")
      }
      return CashPresenter(interactor: interactor)
    }.initCompleted { resolver, presenter in
      (presenter as? CashPresenter)?.view = resolver.resolve(CashViewProtocol.self)
    }.inObjectScope(.container)
  }

}

// MARK: - Cash category

private extension CashAssembly {

  func registerCashCategoryView(container: Container) {
    container.register(CashCategoryViewProtocol.self) {
      guard let presenter = $0.resolve(CashCategoryPresenterProtocol.self) else {
        fatalError("CashCategoryPresenterProtocol is not in container")
      }
      return CashCategoryViewController(presenter: presenter)
    }.inObjectScope(.container)
  }

  func registerCashCategoryInteractor(container: Container) {
    container.register(CashCategoryInteractorProtocol.self) {
      guard let cashDAO = $0.resolve(CashDAO.self) else {
        fatalError("CashDAO is not in container")
      }
      return CashCategoryInteractor(cashDAO: cashDAO)
    }.inObjectScope(.container)
  }

  func registerCashCategoryPresenter(container: Container) {
    container.register(CashCategoryPresenterProtocol.self) {
      guard let interactor = $0.resolve(CashCategoryInteractorProtocol.self) else {
        fatalError("CashCategoryInteractorProtocol is not in container")
      }
      return CashCategoryPresenter(interactor: interactor)
    }.initCompleted { resolver, presenter in
      (presenter as? CashCategoryPresenter)?.view = resolver.resolve(CashCategoryViewProtocol.self)
    }.inObjectScope(.container)
  }

}
