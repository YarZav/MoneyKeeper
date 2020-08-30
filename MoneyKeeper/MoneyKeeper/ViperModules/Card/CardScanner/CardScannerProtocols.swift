//
//  CardScannerProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Foundation
import AVFoundation

//Presenter -> View
protocol CardScannerViewControllerProtocol: class { }

//View -> Presenter
protocol CardScannerPresenterProtocol {
    func scanCode(_ code: String, type: AVMetadataObject.ObjectType)
}

//Presenter - Interactor
protocol CardScannerInteractorProtocol { }

//Presenter - WireFrame
protocol CardScannerWireFrameProtocol {
    func popViewControlelr(from view: CardScannerViewControllerProtocol?, complation: @escaping () -> ())
}
