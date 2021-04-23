//
//  CardsPresenter.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import AVFoundation
import Business

// MARK: - CardsPresenter
class CardsPresenter: BasePresenter {
    
    //Properties
    private weak var view: CardsViewControllerProtocol?
    private let interactor: CardsInteractorProtocol
    private let wireFrame: CardsWireFrameProtocol
    
    private var searchText: String?
    
    //Init
    init(view: CardsViewControllerProtocol, interactor: CardsInteractorProtocol, wireFrame: CardsWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    override func languageChanged() {
        self.view?.updateStringLocalization()
    }
    
    override func userDataReset() {
        self.view?.showNoContentView()
    }
}

// MARK: - Privates
extension CardsPresenter {
    
    private func fetchCards() {
        var cards = self.interactor.getCards()
        if let searchText = self.searchText, !searchText.isEmpty {
            cards = cards.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        if cards.isEmpty {
            self.view?.showNoContentView()
        } else {
            self.view?.setModels(cards)
        }
    }
}

// MARK: - CardsPresenterProtocol
extension CardsPresenter: CardsPresenterProtocol {
    
    func viewLoaded() {
        self.fetchCards()
    }
    
    func presentCardScanner() {
        self.wireFrame.cardScanner(from: self.view, delegate: self)
    }
    
    func searchCards(by text: String?) {
        if (text ?? "") == (self.searchText ?? "") { return }
        self.searchText = text
        self.fetchCards()
    }
    
    func didSelectCard(transition: CardDetailTransitionDelegate) {
        self.wireFrame.cardDetail(from: self.view, transition: transition, delegate: self)
    }
}

// MARK: - CardScannerPresenterDelegate
extension CardsPresenter: CardScannerPresenterDelegate {
    
    func didScanCard(code: String, type: AVMetadataObject.ObjectType) {
        self.view?.getCardTitle({ [weak self] (title) in
//            let cardModel = CardModel(code: code, type: type, title: title)
//            self?.view?.insertModels([cardModel])
//            
//            self?.interactor.saveCard(cardModel, callback: { (error) in
//                if let error = error {
//                    self?.view?.showOkAlertController(title: "CardsWarning".localized(), message: error.localizedDescription, handler: { })
//                }
//            })
        })
    }
}

// MARK: - CardDetailDelegate
extension CardsPresenter: CardDetailDelegate {
    
    func didDeleteModel(_ model: CardModel) {
        self.view?.deleteModel(model)
    }
}
