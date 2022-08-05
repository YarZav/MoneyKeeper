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
    // MARK: - Cash

    container.register(CashDAO.self) { _ in
      return CashDAO(mapper: CashMapper(), coreDataManager: CoreDataManager.shared)
    }.inObjectScope(.container)

    container.register(CashView.self) {
      guard let presenter = $0.resolve(CashPresenter.self) else {
        fatalError("CashPresenter is not in container")
      }
      return CashViewController(presenter: presenter)
    }.inObjectScope(.container)

    container.register(CashWireFrame.self) {
      guard let cashCategoryView = $0.resolve(CashCategoryViewProtocol.self) else {
        fatalError("CashCategoryViewProtocol is not in container")
      }
      return CashWireFrameImp(cashCategoryView: cashCategoryView)
    }.inObjectScope(.container)

    container.register(CashInteractor.self) {
      guard let cashDAO = $0.resolve(CashDAO.self) else {
        fatalError("CashDAO is not in container")
      }
      return CashInteractorImp(cashDAO: cashDAO)
    }.inObjectScope(.container)

    container.register(CashPresenter.self) {
      guard let wireFrame = $0.resolve(CashWireFrame.self) else {
        fatalError("CashWireFrame is not in container")
      }
      guard let interactor = $0.resolve(CashInteractor.self) else {
        fatalError("CashInteractor is not in container")
      }
      return CashPresenterImp(interactor: interactor, wireFrame: wireFrame)
    }.initCompleted { resolver, presenter in
      (presenter as? CashPresenterImp)?.view = resolver.resolve(CashView.self)
    }.inObjectScope(.container)

    // MARK: - Cash category

    container.register(CashCategoryViewProtocol.self) {
      guard let presenter = $0.resolve(CashCategoryPresenterProtocol.self) else {
        fatalError("CashCategoryPresenterProtocol is not in container")
      }
      return CashCategoryViewController(presenter: presenter)
    }.inObjectScope(.container)

    container.register(CashCategoryWireFrameProtocol.self) { _ in
      return CashCategoryWireFrame()
    }.inObjectScope(.container)

    container.register(CashCategoryInteractorProtocol.self) {
      guard let cashDAO = $0.resolve(CashDAO.self) else {
        fatalError("CashDAO is not in container")
      }
      return CashCategoryInteractor(cashDAO: cashDAO)
    }.inObjectScope(.container)

    container.register(CashCategoryPresenterProtocol.self) {
      guard let wireFrame = $0.resolve(CashCategoryWireFrameProtocol.self) else {
        fatalError("CashCategoryWireFrameProtocol is not in container")
      }
      guard let interactor = $0.resolve(CashCategoryInteractorProtocol.self) else {
        fatalError("CashCategoryInteractorProtocol is not in container")
      }
      return CashCategoryPresenter(interactor: interactor, wireFrame: wireFrame)
    }.initCompleted { resolver, presenter in
      (presenter as? CashCategoryPresenter)?.view = resolver.resolve(CashCategoryViewProtocol.self)
    }.inObjectScope(.container)
  }

}

public protocol CashAssembler {

  func cash() -> UIViewController

}

// MARK: - CashAssembler

extension Assembler: CashAssembler {

  public func cash() -> UIViewController {
    guard let view = resolver.resolve(CashView.self) as? UIViewController else {
      fatalError("Fatal Error (Swinject): CashView is not UIViewController")
    }
    return view
  }

  public func category(_ cashModel: CashModel?) -> UIViewController {
    let view = resolver.resolve(CashCategoryViewProtocol.self)
    view?.cashModel = cashModel

    guard let viewController = view as? UIViewController else {
      fatalError("Fatal Error (Swinject): CashView is not UIViewController")
    }

    return viewController
  }

}
