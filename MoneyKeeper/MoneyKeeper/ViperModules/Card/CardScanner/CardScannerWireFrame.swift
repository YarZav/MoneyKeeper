//
//  CardScannerWireFrame.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CardScannerWireFrame
class CardScannerWireFrame: BaseWireFrame { }

// MARK: - CardScannerWireFrameProtocol
extension CardScannerWireFrame: CardScannerWireFrameProtocol {
    
    func popViewControlelr(from view: CardScannerViewControllerProtocol?, complation: @escaping () -> ()) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true, completion: {
            complation()
        })
    }
}
