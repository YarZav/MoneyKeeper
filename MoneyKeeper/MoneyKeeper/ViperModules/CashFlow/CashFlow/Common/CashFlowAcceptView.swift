//
//  CashFlowAcceptView.swift
//  MoneyKeeper
//
//  Created by admin on 26.02.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit
import YZNumPad

// MARK: - CashFlowAcceptStruct
private struct CashFlowAcceptStruct {
    static var totalPriceWidth: CGFloat {
        get {
            switch UIDevice.current.deviceType {
            case .iPhone_5S_SE?:      return 200
            case .iPhone_6_7_8?:      return 276
            case .iPhone_6_7_8_Plus?: return 276
            case .iPhone_X_Xs_11Pro?:       return 276
            case .iPhone_Xr_XsMax_11_11ProMax?:   return 276
            default:                  return 0
            }
        }
    }
}

// MARK: - CashFlowAcceptDelegate
protocol CashFlowAcceptDelegate: class {
    func presentCashFlowCategory()
    func didChangeCashFlowType()
}

// MARK: - CashFlowAcceptView
class CashFlowAcceptView: UIView {
    
    public weak var delegate: CashFlowAcceptDelegate?
    public var buttonConstraint: Constraint!
    private var typeLabel = UILabel(font: UIFont.systemFont(ofSize: 18), textColor: .white)
    private var priceView = UIView()
    private var totalLabel = UILabel(font: UIFont.systemFont(ofSize: 18), textColor: .white, textAlignment: .right)
    private var nextButton: YZRoundButton!

    //Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(color: UIColor, type: CashFlowType) {
        super.init(frame: .zero)
        self.createUI()
    }
}

// MAK: - Publics
extension CashFlowAcceptView {
    
    public func displayTotal(_ total: String?, type: CashFlowType) {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.15) {
            self.priceView.backgroundColor = type.color
            self.typeLabel.text = type.title.localized()
            self.totalLabel.text = total
            self.layoutIfNeeded()
        }
    }
    
    public func updateLocalizedString() {
        self.nextButton.setTitle("CashFlowNext".localized(), for: .normal)
    }
}

// MARK: - Privates
extension CashFlowAcceptView {
    
    private func createUI() {
        self.backgroundColor = backgroundColor
        let color = UIColor.darkViolet.withAlphaComponent(0.5)
        
        self.priceView.cornerRadius(20, color: color)

        let cashFlowTypeButton = UIButton(type: .custom)
        cashFlowTypeButton.addTarget(self, action: #selector(cashFlowTypeAction), for: .touchUpInside)
        
        self.nextButton = YZRoundButton(backgroundColor: color, radius: 20, borderColor: color, borderWidth: 1)
        self.nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        self.nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.nextButton.setTitle("CashFlowNext".localized(), for: .normal)
        self.nextButton.setTitleColor(.white, for: .normal)
        
        self.addSubview(self.priceView)
        self.priceView.addSubview(self.totalLabel)
        self.priceView.addSubview(self.typeLabel)
        self.priceView.addSubview(cashFlowTypeButton)
        self.addSubview(self.nextButton)

        self.nextButton.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(144).priority(900)
            $0.height.equalTo(44).priority(999)
            $0.width.equalTo(144).priority(999)
            self.buttonConstraint = $0.right.equalToSuperview().offset(32).priority(999).constraint
        }
        
        self.priceView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(-26)
            $0.height.equalTo(44)
        }
        
        self.typeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16 + 26)
        }
        
        self.totalLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().offset(-26)
            $0.left.equalTo(self.typeLabel.snp.right).offset(16)
        }
        
        cashFlowTypeButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Actions
extension CashFlowAcceptView {
    
    @objc private func nextAction() {
        self.delegate?.presentCashFlowCategory()
    }
    
    @objc private func cashFlowTypeAction() {
        self.delegate?.didChangeCashFlowType()
    }
}
