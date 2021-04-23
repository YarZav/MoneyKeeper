//  
//  CardDetailPresenter.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

protocol CardDetailDelegate: class {
    func didDeleteModel(_ model: CardModel)
}

// MARK: - CardDetailPresenter
class CardDetailPresenter: BasePresenter {
    
    private weak var view: CardDetailViewProtocol?
    private var wireFrame: CardDetailWireFrameProtocol
    private var interactor: CardDetailInteractorProtocol
    public weak var delegate: CardDetailDelegate?
    
    init(view: CardDetailViewProtocol, wireFrame: CardDetailWireFrameProtocol, interactor: CardDetailInteractorProtocol) {
        self.view = view
        self.wireFrame = wireFrame
        self.interactor = interactor
    }
}

// MARK: - CardDetailPresenterProtocol
extension CardDetailPresenter: CardDetailPresenterProtocol {
    
    func popViewController() {
        self.wireFrame.popViewController(from: self.view) { }
    }
    
    func deleteModel(_ model: CardModel) {
        self.interactor.deleteCardModel(model) { [weak self] (error) in
            guard let self = self else { return }
            Thread.current.doInMainThread {
                if let error = error {
                    self.view?.showOkAlertController(title: "CardDetailWarning".localized(), message: error.localizedDescription, handler: { })
                } else {
                    self.wireFrame.popViewController(from: self.view, completion: {
                        self.delegate?.didDeleteModel(model)
                    })
                }
            }
        }
    }
}
