//
//  CashCategoryPresenter.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service

final class CashCategoryPresenter {
  
  // MARK: - Private property

  private let interactor: CashCategoryInteractorProtocol
  private let categories = CashCategoryType.allCases

  // MARK: - Internal property

  weak var view: CashCategoryViewProtocol?
  var displayedCategories: [CashCategoryType] = []

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
      displayedCategories = categories.filter {
        let cateogoryName = $0.rawValue.localized()
        return cateogoryName.lowercased().contains(text.lowercased())
      }
    }
    view?.reloadData()
  }

  func didSelectCategory(_ categoryType: CashCategoryType, for cashModel: CashModel?) {
    guard var cashModel = cashModel else {
      fatalError("Cash model for category can not be nil")
    }
    cashModel.categoryType = categoryType

    interactor.saveCash(cashModel) { [weak self] _ in
      self?.view?.didComplete()
    }
  }

}
