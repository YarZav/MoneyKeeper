//  
//  CardDetailProtocols.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

// VIEW -> PRESENTER
protocol CardDetailPresenterProtocol: AnyObject {
    func popViewController()
//    func deleteModel(_ model: CardModel)
}

// PRESENTER -> VIEW
protocol CardDetailViewProtocol: BaseViewControllerProtocol { }

// PRESENTER -> WIREFRAME
protocol CardDetailWireFrameProtocol: AnyObject {
    func popViewController(from view: CardDetailViewProtocol?, completion: @escaping () -> Void)
}

// INTERACTOR -> PRESENTER
protocol CardDetailInteractorProtocol: AnyObject {
//    func deleteCardModel(_ model: CardModel, callback: @escaping (Error?) -> Void)
}
