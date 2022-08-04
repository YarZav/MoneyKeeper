//
//  CardsProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import Business

//Presenter -> View
protocol CardsViewControllerProtocol: BaseViewControllerProtocol {
    func updateStringLocalization()
    func showNoContentView()
//    func setModels(_ models: [CardModel])
//    func insertModels(_ models: [CardModel])
//    func deleteModel(_ model: CardModel)
    func getCardTitle(_ callback: @escaping (String) -> Void)
}

//View -> Presenter
protocol CardsPresenterProtocol {
    func viewLoaded()
    func presentCardScanner()
    func searchCards(by text: String?)
    func didSelectCard(transition: CardDetailTransitionDelegate)
}

//Presenter - Interactor
protocol CardsInteractorProtocol {
//    func getCards() -> [CardModel]
//    func saveCard(_ model: CardModel, callback: @escaping (Error?) -> Void)
}

//Presenter - WireFrame
protocol CardsWireFrameProtocol {
    func cardScanner(from view: CardsViewControllerProtocol?, delegate: CardScannerPresenterDelegate?)
//    func cardDetail(from view: CardsViewControllerProtocol?, transition: CardDetailTransitionDelegate, delegate: CardDetailDelegate?)
}
