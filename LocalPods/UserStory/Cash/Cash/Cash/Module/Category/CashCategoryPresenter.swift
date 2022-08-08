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

  private let categories = CashCategoryModel.categories

  // MARK: - Internal property

  weak var view: CashCategoryViewProtocol?

  var displayedCategories: [CashCategoryModel] = []

  // MARK: - Init

  init(interactor: CashCategoryInteractorProtocol) {
    self.interactor = interactor
  }

}

// MARK: - CashCategoryPresenterProtocol

extension CashCategoryPresenter: CashCategoryPresenterProtocol {

  func searchCategory(by text: String) {
    if text.isEmpty {
      displayedCategories = categories
    } else {
      displayedCategories = categories.filter { $0.title.lowercased().contains(text.lowercased()) }
    }
    view?.reloadData()
  }

  func didSelectCategory(_ category: CashCategoryModel, for cashModel: CashModel?) {
    guard var cashModel = cashModel else {
      fatalError("Cash model for category can not be nil")
    }
    cashModel.cashCategory = category

    interactor.saveCash(cashModel) { [weak self] _ in
      self?.view?.didComplete()
    }
  }

}
