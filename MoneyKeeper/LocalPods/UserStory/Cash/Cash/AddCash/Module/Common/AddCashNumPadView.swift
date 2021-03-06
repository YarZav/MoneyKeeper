//
//  AddCashNumPadView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZNumPad

// MARK: - AddCashNumPadDelegate
protocol AddCashNumPadDelegate: class {
    func price(_ price: String?)
}

// MARK: - AddCashNumPadStruct
private struct AddCashNumPadStruct {
    static var horizontalSpacing: CGFloat {
        get {
            switch UIDevice.current.type {
            case .iPhone_5S_SE?: return 30
            case .iPhone_6_7_8?:      return 43
            case .iPhone_6_7_8_Plus?: return 43
            case .iPhone_X_Xs_11Pro?:       return 50
            case .iPhone_Xr_XsMax_11_11ProMax?:   return 50
            default:                  return 0
            }
        }
    }
    
    static var verticalSpacing: CGFloat {
        get {
            switch UIDevice.current.type {
            case .iPhone_5S_SE?: return 10
            case .iPhone_6_7_8?:      return 20
            case .iPhone_6_7_8_Plus?: return 25
            case .iPhone_X_Xs_11Pro?:       return 25
            case .iPhone_Xr_XsMax_11_11ProMax?:   return 25
            default:                  return 0
            }
        }
    }
    
    static var buttonRadius: CGFloat {
        get {
            switch UIDevice.current.type {
            case .iPhone_5S_SE?: return 29
            case .iPhone_6_7_8?:      return 29
            case .iPhone_6_7_8_Plus?: return 35
            case .iPhone_X_Xs_11Pro?:       return 35
            case .iPhone_Xr_XsMax_11_11ProMax?:   return 35
            default:                  return 0
            }
        }
    }
}

// MARK: - CashNumPadView
final class AddCashNumPadView: UIView {
    
    private var priceLengthLimit: Int = 0
    private var numPadView: YZNumPadView!
    private var price: String = ""
    private var point: String?
    public weak var delegate: AddCashNumPadDelegate?

    //Init
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(priceLengthLimit: Int) {
        super.init(frame: .zero)
        self.priceLengthLimit = priceLengthLimit
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Publics
extension AddCashNumPadView {
    
    public func dropPrice() {
        self.price = ""
        self.delegate?.price(self.price)
    }
}

// MARK: - Perivates
extension AddCashNumPadView {
    
    private func createUI() {
        self.numPadView = YZNumPadView(config: self.getNumPadConfig())
        self.numPadView.delegate = self
        self.addSubview(self.numPadView)
//        self.numPadView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    private func getNumPadConfig() -> YZNumPadViewConfiguration {
        var numPadViewStruct = YZNumPadViewConfiguration()
        numPadViewStruct.viewColor = .anthracite
        numPadViewStruct.borderColor = .darkViolet
        numPadViewStruct.buttonColor = .anthracite
        numPadViewStruct.textColor = .white
        numPadViewStruct.horizontalSpacing = AddCashNumPadStruct.horizontalSpacing
        numPadViewStruct.verticalSpacing = AddCashNumPadStruct.verticalSpacing
        numPadViewStruct.buttonRadius = AddCashNumPadStruct.buttonRadius
        numPadViewStruct.textSize = 36
        numPadViewStruct.deleteIcon = UIImage(named: "DeleteSymbol")
        return numPadViewStruct
    }
}

// MARK: - YZNumPadViewDelegate
extension AddCashNumPadView: YZNumPadViewDelegate {
    
    func didTapNumber(_ number: Int, numPadView: YZNumPadView) {
        guard self.price.count <= self.priceLengthLimit else { return }
//        self.price.addNumberToPriceString(number, pointSymbol: self.point)
        self.delegate?.price(self.price)
    }
    
    func didTapDecimapSeparator(_ decimapSeparator: String?, numPadView: YZNumPadView) {
        guard let decimapSeparator = decimapSeparator else { return }
        self.point = decimapSeparator
        
        guard self.price.count <= self.priceLengthLimit else { return }
//        self.price.addDecimalSeparator(decimapSeparator)
        self.delegate?.price(self.price)
    }
    
    func didTapDelete(numPadView: YZNumPadView) {
//        self.price.deleteLastCharacter()
        self.delegate?.price(self.price)
    }
}
