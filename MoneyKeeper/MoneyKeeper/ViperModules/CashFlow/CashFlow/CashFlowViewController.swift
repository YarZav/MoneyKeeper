//
//  CashFlowViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 10.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - CashFlowViewStruct
private struct CashFlowViewStruct {
    
    static var numPadViewTopOffset: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5S_SE?: return 43
            case .iPhone_6_7_8?:      return 80
            case .iPhone_6_7_8_Plus?: return 80
            case .iPhone_X_Xs_11Pro?:       return 100
            case .iPhone_Xr_XsMax_11_11ProMax?:   return 180
            default:                  return 0
            }
        }
    }
    
    static var numPadViewBottomOffset: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5S_SE?: return 10
            case .iPhone_6_7_8?:      return 34
            case .iPhone_6_7_8_Plus?: return 34
            case .iPhone_X_Xs_11Pro?:       return 50
            case .iPhone_Xr_XsMax_11_11ProMax?:   return 50
            default:                  return 0
            }
        }
    }
}

// MARK: - CashFlowViewController
class CashFlowViewController: BaseViewController {
    
    //Properties
    public var presenter: CashFlowPresenterProtocol!
    public var type: CashFlowType = .outcome
    
    private var priceView = CashFlowPriceView()
    private var numPadView = CashFlowNumPadView(priceLengthLimit: 7)
    private var acceptView: CashFlowAcceptView!
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidApepar(type: self.type)
    }
}

// MARK: - CashFlowViewControllerProtocol
extension CashFlowViewController: CashFlowViewControllerProtocol {
    
    func updateStringLocalization() {
        self.acceptView.updateLocalizedString()
    }
    
    func dropPrice() {
        self.numPadView.dropPrice()
    }
    
    func setTotalPrice(_ total: String?) {
        self.acceptView.displayTotal(total, type: self.type)
    }
}

// MARK: - Privates
extension CashFlowViewController {
    
    private func createUI() {
        let backgroundColor = UIColor.anthracite
        self.view.backgroundColor = backgroundColor
        
        self.priceView.backgroundColor = backgroundColor
        self.numPadView.delegate = self
        
        self.acceptView = CashFlowAcceptView(color: UIColor.darkViolet.withAlphaComponent(0.5), type: self.type)
        self.acceptView.backgroundColor = backgroundColor
        self.acceptView.delegate = self
        
        self.view.addSubview(self.priceView)
        self.view.addSubview(self.numPadView)
        self.view.addSubview(self.acceptView)
        
        self.priceView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        self.numPadView.snp.makeConstraints {
            $0.top.equalTo(self.priceView.snp.bottom).offset(CashFlowViewStruct.numPadViewTopOffset)
            $0.left.right.equalToSuperview()
        }
        
        self.acceptView.snp.makeConstraints {
            $0.top.equalTo(self.numPadView.snp.bottom).offset(CashFlowViewStruct.numPadViewBottomOffset)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        self.ativateConstraint(false)
    }
    
    private func ativateConstraint(_ isActivate: Bool) {
        if isActivate {
            self.acceptView.buttonConstraint.activate()
            self.priceView.titleConstraint.activate()
        } else {
            self.acceptView.buttonConstraint.deactivate()
            self.priceView.titleConstraint.deactivate()
        }
    }
    
    private func ativateAnimationConstraint(_ activate: Bool) {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.15, animations: {
            self.ativateConstraint(activate)
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - CashFlowNumPadDelegate
extension CashFlowViewController: CashFlowNumPadDelegate {
    
    func price(_ price: String?) {
        if let price = price, !(price.isEmpty || price == "0") {
            self.priceView.priceLabel.text = price
            self.ativateAnimationConstraint(true)
        } else {
            self.priceView.priceLabel.text = nil
            self.ativateAnimationConstraint(false)
        }
    }
}

// MARK: - CashFlowExtraDelegate
extension CashFlowViewController: CashFlowAcceptDelegate {
    
    func didChangeCashFlowType() {
        switch self.type {
        case .outcome: self.type = .income
        case .income:  self.type = .outcome
        }
        
        self.presenter.viewDidApepar(type: self.type)
    }
    
    func presentCashFlowCategory() {
        guard let price = self.priceView.priceLabel.text, !price.isEmpty else { return }
        self.presenter.presentCashFlowCategory(price: price, type: self.type)
    }
}
