//
//  CashAssembly.swift
//  Business
//
//  Created by 19205313 on 31.05.2021.
//

import Swinject

public final class CashAssembly {

  public init() { }

}

// MARK: - Assembly

extension CashAssembly: Assembly {

  public func assemble(container: Container) {
    container.register(CashView.self) {
      guard let presenter = $0.resolve(CashPresenter.self) else {
        fatalError("CashPresenter is not in container")
      }
      return CashViewController(presenter: presenter)
    }.inObjectScope(.container)

    container.register(CashWireFrame.self) { _ in
      return CashWireFrameImp()
    }.inObjectScope(.container)

    container.register(CashInteractor.self) { _ in
      return CashInteractorImp()
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

}
