//  
//  CardDetailWireFrame.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CardDetailWireFrame
class CardDetailWireFrame: BaseWireFrame { }

// MARK: - CardDetailWireFrameProtocol
extension CardDetailWireFrame: CardDetailWireFrameProtocol {
    
    func popViewController(from view: CardDetailViewProtocol?, completion: @escaping () -> Void) {
        guard let view = view as? UIViewController else { return }
        view.dismiss(animated: true, completion: completion)
    }
}
