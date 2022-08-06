//
//  CashCategoryPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Business

final class CashCategoryPresenter {
  
  // MARK: - Private property

  private let interactor: CashCategoryInteractorProtocol
  private let wireFrame: CashCategoryWireFrameProtocol

  // MARK: - Internal property

  weak var view: CashCategoryViewProtocol?

  // MARK: - Init

  init(interactor: CashCategoryInteractorProtocol, wireFrame: CashCategoryWireFrameProtocol) {
    self.interactor = interactor
    self.wireFrame = wireFrame
  }

}

// MARK: - CashCategoryPresenterProtocol

extension CashCategoryPresenter: CashCategoryPresenterProtocol {

  var categories: [CashCategoryModel] {
    CashCategoryModel.categories
  }

  func didSelectCategory(_ category: CashCategoryModel) {
    guard var cashModel = view?.cashModel else { return }
    cashModel.cashCategory = category

    interactor.saveCash(cashModel) { [weak self] _ in
      self?.view?.didComplete()
    }
  }

}
