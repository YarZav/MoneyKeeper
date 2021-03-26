//
//  CardsWireFrame.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CardsWireFrame
class CardsWireFrame: BaseWireFrame { }

// MARK: - CardsWireFrameProtocol
extension CardsWireFrame: CardsWireFrameProtocol {
    
    func cardScanner(from view: CardsViewControllerProtocol?, delegate: CardScannerPresenterDelegate?) {
//        guard let viewController = view as? UIViewController else { return }
//        let scannerViewController = self.resolver.cardScannerViewCotnroller(delegate: delegate)
//        viewController.navigationController?.pushViewController(scannerViewController, animated: true)
    }
    
    func cardDetail(from view: CardsViewControllerProtocol?, transition: CardDetailTransitionDelegate, delegate: CardDetailDelegate?) {
//        guard let viewController = view as? UIViewController else { return }
//        let detailViewController = self.resolver.detailCardController(transition.model, delegate: delegate)
//        detailViewController.transitioningDelegate = transition
//        detailViewController.modalPresentationStyle = .custom
//        viewController.present(detailViewController, animated: true) { }
    }
}
