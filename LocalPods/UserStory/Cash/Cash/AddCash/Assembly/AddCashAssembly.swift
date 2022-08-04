//
//  AddCashAssembly.swift
//  Business
//
//  Created by 19205313 on 31.05.2021.
//

import Swinject

public final class AddCashAssembly {

  public init() { }

}

// MARK: - Assembly

extension AddCashAssembly: Assembly {

  public func assemble(container: Container) {
    container.register(AddCashView.self) {
      guard let presenter = $0.resolve(AddCashPresenter.self) else {
        fatalError("AddCashPresenter is not in container")
      }
      return AddCashViewController(presenter: presenter)
    }.inObjectScope(.container)

    container.register(AddCashWireFrame.self) { _ in
      return AddCashWireFrameImp()
    }.inObjectScope(.container)

    container.register(AddCashInteractor.self) { _ in
      return AddCashInteractorImp()
    }.inObjectScope(.container)

    container.register(AddCashPresenter.self) {
      guard let wireFrame = $0.resolve(AddCashWireFrame.self) else {
        fatalError("AddCashWireFrame is not in container")
      }
      guard let interactor = $0.resolve(AddCashInteractor.self) else {
        fatalError("AddCashInteractor is not in container")
      }
      return AddCashPresenterImp(interactor: interactor, wireFrame: wireFrame)
    }.initCompleted { resolver, presenter in
      (presenter as? AddCashPresenterImp)?.view = resolver.resolve(AddCashView.self)
    }.inObjectScope(.container)
  }

}

public protocol AddCashAssembler {

  func addCash() -> UIViewController

}

// MARK: - AddCashAssembler

extension Assembler: AddCashAssembler {

  public func addCash() -> UIViewController {
    guard let view = resolver.resolve(AddCashView.self) as? UIViewController else {
      fatalError("Fatal Error (Swinject): AddCashView is not UIViewController")
    }
    return view
  }

}
