//  
//  AboutProgramPresenter.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - AboutProgramPresenter
class AboutProgramPresenter: BasePresenter {
    
    private weak var view: AboutProgramViewProtocol?
    private var wireFrame: AboutProgramWireFrameProtocol
    private var interactor: AboutProgramInteractorProtocol
    
    init(view: AboutProgramViewProtocol, wireFrame: AboutProgramWireFrameProtocol, interactor: AboutProgramInteractorProtocol) {
        self.view = view
        self.wireFrame = wireFrame
        self.interactor = interactor
    }
}

// MARK: - AboutProgramPresenterProtocol
extension AboutProgramPresenter: AboutProgramPresenterProtocol { }
