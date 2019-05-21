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
            case .iPhone_5_5C_5S_SE?: return 43
            case .iPhone_6_7_8?:      return 80
            case .iPhone_6_7_8_Plus?: return 80
            case .iPhone_X_Xs?:       return 100
            case .iPhone_Xr_XsMax?:   return 180
            default:                  return 0
            }
        }
    }
    
    static var numPadViewBottomOffset: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5_5C_5S_SE?: return 10
            case .iPhone_6_7_8?:      return 34
            case .iPhone_6_7_8_Plus?: return 34
            case .iPhone_X_Xs?:       return 50
            case .iPhone_Xr_XsMax?:   return 50
            default:                  return 0
            }
        }
    }
}

// MARK: - CashFlowViewController
class CashFlowViewController: BaseViewController {
    
    //Properties
    public var presenter: CashFlowPresenterProtocol!
    private var priceView: CashFlowPriceView!
    private var numPadView: CashFlowNumPadView!
    private var extraView: CashFlowExtraView!
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillApepar()
    }
}

// MARK: - CashFlowViewControllerProtocol
extension CashFlowViewController: CashFlowViewControllerProtocol {
    
    func dropPrice() {
        self.numPadView.dropPrice()
    }
    
    func setTotalPrice(_ total: String?) {
        self.extraView.displayTotal(total)
    }
}

// MARK: - Privates
extension CashFlowViewController {
    
    private func createUI() {
        let backgroundColor = UIColor.anthracite
        self.view.backgroundColor = backgroundColor
        
        self.priceView = CashFlowPriceView()
        self.priceView.backgroundColor = backgroundColor

        self.numPadView = CashFlowNumPadView(priceLengthLimit: 7)
        self.numPadView.delegate = self
        
        self.extraView = CashFlowExtraView(color: UIColor.darkVioletTranslucent)
        self.extraView.backgroundColor = backgroundColor
        self.extraView.delegate = self
        
        self.view.addSubview(self.priceView)
        self.view.addSubview(self.numPadView)
        self.view.addSubview(self.extraView)
        
        self.priceView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        self.numPadView.snp.makeConstraints {
            $0.top.equalTo(self.priceView.snp.bottom).offset(CashFlowViewStruct.numPadViewTopOffset)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        self.extraView.snp.makeConstraints {
            $0.top.equalTo(self.numPadView.snp.bottom).offset(CashFlowViewStruct.numPadViewBottomOffset)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        self.ativateConstraint(false)
    }
    
    private func ativateConstraint(_ isActivate: Bool) {
        if isActivate {
            self.extraView.buttonConstraint.activate()
            self.priceView.titleConstraint.activate()
        } else {
            self.extraView.buttonConstraint.deactivate()
            self.priceView.titleConstraint.deactivate()
        }
    }
    
    private func ativateAnimationConstraint(_ activate: Bool) {
        self.view.layoutIfNeeded()
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
extension CashFlowViewController: CashFlowExtraDelegate {
    
    func presentCashFlowCategory() {
        guard let price = self.priceView.priceLabel.text, !price.isEmpty else { return }
        self.presenter.presentCashFlowCategory(price: price)
    }
}
