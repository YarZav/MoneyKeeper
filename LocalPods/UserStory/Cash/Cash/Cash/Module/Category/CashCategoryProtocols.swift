//
//  CashCategoryProtocols.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import UIKit
import Business

public protocol CashCategoryProtocol: CashCategoryInputProtocol & CashCategoryOutputProtocol { }

// INPUT
public protocol CashCategoryInputProtocol {

  var cashModel: CashModel? { get set }
  var isOpened: Bool { get set }

}

// OUTPUT
public protocol CashCategoryOutputProtocol {

    var completion: (() -> Void)? { get set }
    var hide: (() -> Void)? { get set }

}

// PRESENTER -> VIEW
protocol CashCategoryViewProtocol: AnyObject {

  func reloadData()
  func didComplete()

}

// VIEW -> PRESENTER
protocol CashCategoryPresenterProtocol {

  var displayedCategories: [CashCategoryModel] { get }
  func searchCategory(by text: String)
  func didSelectCategory(_ category: CashCategoryModel, for cashModel: CashModel?)

}

// PRESENTER - INTERACTOR
protocol CashCategoryInteractorProtocol {

  func saveCash(_ cashModel: CashModel, callback: @escaping (Error?) -> Void)

}
