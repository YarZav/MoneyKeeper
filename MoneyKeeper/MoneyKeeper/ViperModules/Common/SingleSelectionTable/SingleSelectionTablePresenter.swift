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
    
    override func languageChanged() {
        self.view?.updateLocalizedStrings()
    }
}

// MARK: - SingleSelectionTablePresenterProtocol
extension SingleSelectionTablePresenter: SingleSelectionTablePresenterProtocol {
    
    func viewLoaded() {
        let models = self.interactor.getModels()
        self.view?.insertModels(models)
    }
    
    func willSelectRow(at indexPath: IndexPath, oldIndexPath: IndexPath?) {
        self.interactor.didSelectModel(at: indexPath) { [weak self] (error) in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.view?.showOkAlertController(title: "SingleWarining".localized(), message: error.localizedDescription, handler: { })
            } else {
                strongSelf.view?.setSelectedModel(at: indexPath, oldIndexPath: oldIndexPath)
            }
        }
    }
}
