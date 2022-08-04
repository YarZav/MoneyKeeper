//
//  CardScannerPresenter.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import AVFoundation

// MARK: - CardScannerPresenterDelegate
protocol CardScannerPresenterDelegate: AnyObject {
    func didScanCard(code: String, type: AVMetadataObject.ObjectType)
}

// MARK: - CardScannerPresenter
class CardScannerPresenter: BasePresenter {
    
    //Properties
    private weak var view: CardScannerViewControllerProtocol?
    private let interactor: CardScannerInteractorProtocol
    private let wireFrame: CardScannerWireFrameProtocol
    public var delegate: CardScannerPresenterDelegate?
    
    //Init
    init(view: CardScannerViewControllerProtocol, interactor: CardScannerInteractorProtocol, wireFrame: CardScannerWireFrameProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

// MARK: - CardScannerPresenterProtocol
extension CardScannerPresenter: CardScannerPresenterProtocol {
    
    func scanCode(_ code: String, type: AVMetadataObject.ObjectType) {
        self.wireFrame.popViewControlelr(from: self.view) {
            self.delegate?.didScanCard(code: code, type: type)
        }
    }
}
