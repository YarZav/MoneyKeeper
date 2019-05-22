//
//  CashFlowExtraView.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - CashFlowViewStruct
private struct CashFlowExtraStruct {
    
    static var totalPriceWidth: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5_5C_5S_SE?: return 200
            case .iPhone_6_7_8?:      return 276
            case .iPhone_6_7_8_Plus?: return 276
            case .iPhone_X_Xs?:       return 276
            case .iPhone_Xr_XsMax?:   return 276
            default:                  return 0
            }
        }
    }
}

// MARK: - CashFlowExtraDelegate
protocol CashFlowExtraDelegate: class {
    func presentCashFlowCategory()
}

// MARK: - CashFlowExtraView
class CashFlowExtraView: UIView {
    
    private var type: CashFlowType = .consumption
    private var color: UIColor = .white
    public var buttonConstraint: Constraint!
    public var totalLabel: MarginLabel!
    public weak var delegate: CashFlowExtraDelegate?

    //Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(color: UIColor, type: CashFlowType) {
        super.init(frame: .zero)
        self.color = color
        self.type = type
        self.createUI()
    }
}

// MAK: - Publics
extension CashFlowExtraView {
    
    public func displayTotal(_ total: String?) {
        self.totalLabel.text = self.type.title + " " + (total ?? "?")
    }
}

// MARK: - Privates
extension CashFlowExtraView {
    
    private func createUI() {
        self.backgroundColor = backgroundColor

        self.totalLabel = MarginLabel()
        self.totalLabel.textAlignment = .right
        self.totalLabel.font = UIFont.systemFont(ofSize: 18)
        self.totalLabel.backgroundColor = self.color
        self.totalLabel.textColor = .white
        self.totalLabel.layer.masksToBounds = true
        self.totalLabel.layer.cornerRadius = 20
        
        let nextButton = RoundButton(backgroundColor: self.color, radius: 20, borderColor: color)
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        nextButton.setTitle("Далее", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        
        self.addSubview(self.totalLabel)
        self.addSubview(nextButton)

        nextButton.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(144).priority(900)
            $0.height.equalTo(44)
            $0.width.equalTo(144)
            self.buttonConstraint = $0.right.equalToSuperview().offset(32).priority(999).constraint
        }
        
        self.totalLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(-26)
            $0.height.equalTo(44)
            $0.width.equalTo(CashFlowExtraStruct.totalPriceWidth)
        }
    }
}

// MARK: - Actions
extension CashFlowExtraView {
    
    @objc private func nextAction() {
        self.delegate?.presentCashFlowCategory()
    }
}
