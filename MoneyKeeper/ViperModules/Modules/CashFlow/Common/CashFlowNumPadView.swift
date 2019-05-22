//
//  CashFlowNumPadView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowNumPadDelegate
protocol CashFlowNumPadDelegate: class {
    func price(_ price: String?)
}

// MARK: - CashFlowNumPadStruct
struct CashFlowNumPadStruct {
    static var horizontalSpacing: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5_5C_5S_SE?: return 30
            case .iPhone_6_7_8?:      return 43
            case .iPhone_6_7_8_Plus?: return 43
            case .iPhone_X_Xs?:       return 50
            case .iPhone_Xr_XsMax?:   return 50
            default:                  return 0
            }
        }
    }
    
    static var verticalSpacing: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5_5C_5S_SE?: return 10
            case .iPhone_6_7_8?:      return 20
            case .iPhone_6_7_8_Plus?: return 25
            case .iPhone_X_Xs?:       return 25
            case .iPhone_Xr_XsMax?:   return 25
            default:                  return 0
            }
        }
    }
    
    static var buttonRadius: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5_5C_5S_SE?: return 29
            case .iPhone_6_7_8?:      return 29
            case .iPhone_6_7_8_Plus?: return 35
            case .iPhone_X_Xs?:       return 35
            case .iPhone_Xr_XsMax?:   return 35
            default:                  return 0
            }
        }
    }
    
    static var textSize: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5_5C_5S_SE?: return 36
            case .iPhone_6_7_8?:      return 36
            case .iPhone_6_7_8_Plus?: return 36
            case .iPhone_X_Xs?:       return 36
            case .iPhone_Xr_XsMax?:   return 36
            default:                  return 0
            }
        }
    }
}

// MARK: - CashFlowNumPadView
class CashFlowNumPadView: UIView {
    
    private var priceLengthLimit: Int!
    private var numPadView: NumPadView!
    private var price: String = ""
    private var point: String?
    public weak var delegate: CashFlowNumPadDelegate?

    //Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(priceLengthLimit: Int) {
        super.init(frame: .zero)
        self.priceLengthLimit = priceLengthLimit
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publics
extension CashFlowNumPadView {
    
    public func dropPrice() {
        self.price = ""
        self.delegate?.price(self.price)
    }
}

// MARK: - Perivates
extension CashFlowNumPadView {
    
    private func createUI() {
        self.numPadView = NumPadView(viewStruct: self.getNumPadViewStruct())
        self.numPadView.delegate = self
        
        self.addSubview(self.numPadView)
        self.numPadView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func getNumPadViewStruct() -> NumPadViewStruct {
        var numPadViewStruct = NumPadViewStruct()
        numPadViewStruct.viewColor = UIColor.anthracite
        numPadViewStruct.borderColor = UIColor.darkViolet
        numPadViewStruct.buttonColor = UIColor.anthracite
        numPadViewStruct.textColor = .white
        numPadViewStruct.horizontalSpacing = CashFlowNumPadStruct.horizontalSpacing
        numPadViewStruct.verticalSpacing = CashFlowNumPadStruct.verticalSpacing
        numPadViewStruct.buttonRadius = CashFlowNumPadStruct.buttonRadius
        numPadViewStruct.textSize = CashFlowNumPadStruct.textSize
        numPadViewStruct.deleteIcon = "DeleteSymbol"
        return numPadViewStruct
    }
}

// MARK: - NumPadViewDelegate
extension CashFlowNumPadView: NumPadViewDelegate {
    
    func numberAction(number: String) {
        guard self.price.count <= self.priceLengthLimit else { return }
        
        if self.price == "0" {
            self.price.removeFirst()
        }
        
        let text = self.price
        if let pointSymbol = self.point, let range = text.range(of: pointSymbol), String(text[range.upperBound...]).count == 2 {
            return
        }
        self.price.append(number)
        
        self.delegate?.price(self.price)
    }
    
    func pointAction(_ point: String) {
        self.point = point
        
        guard self.price.count <= self.priceLengthLimit else { return }
        let text = self.price
        
        if text.count == 0 {
            self.price = "0" + point
        } else if !text.contains(point) {
            self.price.append(point)
        }
        
        self.delegate?.price(self.price)
    }
    
    func deleteAction() {
        if self.price == "0" { return }
        
        self.price.removeLast()
        if self.price.count == 0 { self.price = "0" }
        
        self.delegate?.price(self.price)
    }
}
