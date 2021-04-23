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
protocol CardDetailPresenterProtocol: class {
    func popViewController()
    func deleteModel(_ model: CardModel)
}

// PRESENTER -> VIEW
protocol CardDetailViewProtocol: BaseViewControllerProtocol { }

// PRESENTER -> WIREFRAME
protocol CardDetailWireFrameProtocol: class {
    func popViewController(from view: CardDetailViewProtocol?, completion: @escaping () -> Void)
}

// INTERACTOR -> PRESENTER
protocol CardDetailInteractorProtocol: class {
    func deleteCardModel(_ model: CardModel, callback: @escaping (Error?) -> Void)
}
