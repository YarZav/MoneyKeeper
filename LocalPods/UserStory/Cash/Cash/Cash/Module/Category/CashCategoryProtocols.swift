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

protocol CashCategoryViewDelegate: AnyObject {

  func didComplete()

}

//Presenter -> View
protocol CashCategoryViewProtocol: AnyObject {

  var cashModel: CashModel? { get set }
  var delegate: CashCategoryViewDelegate? { get set }
  var isOpened: Bool { get set }
  func didComplete()

}

//View -> Presenter
protocol CashCategoryPresenterProtocol {

  var categories: [CashCategoryModel] { get }
  func didSelectCategory(_ category: CashCategoryModel)

}

//Presenter - Interactor
protocol CashCategoryInteractorProtocol {

  func saveCash(_ cashModel: CashModel, callback: @escaping (Error?) -> Void)

}

//Presenter - WireFrame
protocol CashCategoryWireFrameProtocol {

//  func popViewController(from view: CashCategoryViewProtocol?)

}
