//  
//  SingleSelectionTablePresenter.swift
//  MoneyKeeper
//
//  Created by admin on 04/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - SingleSelectionTablePresenter
class SingleSelectionTablePresenter: BasePresenter {
  fileprivate weak var view: SingleSelectionTableViewProtocol?
  fileprivate var wireFrame: SingleSelectionTableWireFrameProtocol
  fileprivate var interactor: SingleSelectionTableInteractorProtocol

  init(view: SingleSelectionTableViewProtocol, wireFrame: SingleSelectionTableWireFrameProtocol, interactor: SingleSelectionTableInteractorProtocol) {
    self.view = view
    self.wireFrame = wireFrame
    self.interactor = interactor
  }
}

// MARK: - SingleSelectionTablePresenterProtocol
extension SingleSelectionTablePresenter: SingleSelectionTablePresenterProtocol { }
