//
//  DIResolver+Cards.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CardsDIResolver
extension DIResolver {
    
    // Card list
    func cardsViewCotnroller() -> UIViewController {
        let view = CardsViewController()
        let interactor = CardsInteractor(cardManager: self.cardManager)
        let wireFrame = CardsWireFrame(resolver: self)
        let presenter = CardsPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        
        return view
    }
    
    // Card scanner
    func cardScannerViewCotnroller(delegate: CardScannerPresenterDelegate?) -> UIViewController {
        let view = CardScannerViewController()
        let interactor = CardScannerInteractor()
        let wireFrame = CardScannerWireFrame(resolver: self)
        let presenter = CardScannerPresenter(view: view, interactor: interactor, wireFrame: wireFrame)
        
        view.presenter = presenter
        presenter.delegate = delegate
        
        return view
    }
    
    // Card detail
    func detailCardController(_ model: CardModel, delegate: CardDetailDelegate?) -> UIViewController {
        let view = CardDetailViewController()
        let interactor = CardDetailInteractor(cardManager: self.cardManager)
        let wireFrame = CardDetailWireFrame(resolver: self)
        let presenter = CardDetailPresenter(view: view, wireFrame: wireFrame, interactor: interactor)
        
        view.presenter = presenter
        view.model = model
        presenter.delegate = delegate
        
        return view
    }
}
