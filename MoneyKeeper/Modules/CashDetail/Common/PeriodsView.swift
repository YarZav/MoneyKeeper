//
//  PeriodsView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 18/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - PeriodType
enum PeriodType: Int, CaseIterable {
    case week   = 0         //one week
    case month  = 1         //ome month
    case year   = 2         //one year
    case all    = 3         //all period
    
    var title: String {
        switch self {
        case .week:     return "CashFlowCategoryDetailWeek"//.localized()
        case .month:    return "CashFlowCategoryDetailMonth"//.localized()
        case .year:     return "CashFlowCategoryDetailYear"//.localized()
        case .all:      return "CashFlowCategoryDetailAllTime"//.localized()
        }
    }
    
    var startDate: Date {
        let today = Date()
        var timeOffset = 0
        
        switch self {
        case .week:     timeOffset = -6 * 24 * 60 * 60
        case .month:    timeOffset = -29 * 24 * 60 * 60
        case .year:     timeOffset = -364 * 24 * 60 * 60
        case .all:      return Date(timeIntervalSince1970: 0)
        }
        
        let timeInterval = TimeInterval(timeOffset)
        return today.addingTimeInterval(timeInterval)
    }
    
    var endDate: Date {
        return Date()
    }
}

// MARK: - PeriodsViewDelegate
protocol PeriodsViewDelegate: class {
    func didSelectPeriod(_ period: PeriodType)
}

// MARK: - PeriodsView
class PeriodsView: UIView {
    
    //Properties
    public weak var delegate: PeriodsViewDelegate?
    private var selectedPeriod: PeriodType
    private var buttons = [UIButton]()
    
    //Init
    init(selectedPeriod: PeriodType) {
        self.selectedPeriod = selectedPeriod
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("PeriodsView: use - init(selectedPeriod: PeriodType)")
    }
}

// MARK: - Publics
extension PeriodsView {
    
    public func updateStringLocalization() {
//        for (index, button) in self.buttons.enumerated() {
//            button.setTitle(PeriodType(rawValue: index)?.title.localized(), for: .normal)
//        }
    }
}

// MARK: - Prviates
extension PeriodsView {
    
    private func createUI() {
        var prevButton: UIButton?
        
        PeriodType.allCases.enumerated().forEach { (index, element) in
            let btn = self.createButton(type: element)
            
            self.addSubview(btn)
            
            btn.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
                
                if let prevButton = prevButton {
                    $0.left.equalTo(prevButton.snp.right)
                    $0.width.equalTo(prevButton.snp.width)
                } else {
                    $0.left.equalToSuperview()
                }
                
                if index == PeriodType.allCases.count - 1 {
                    $0.right.equalToSuperview()
                }
            }
            
            if index != PeriodType.allCases.count - 1 {
                let line = self.createLineView()
                line.layer.zPosition = 10
                
                self.addSubview(line)
                
                line.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.width.equalTo(1)
                    $0.left.equalTo(btn.snp.right)
                }
            }
            
            prevButton = btn
        }
    }
    
    private func createButton(type: PeriodType) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .anthracite
        btn.tag = type.rawValue
//        btn.setTitle(type.title.localized(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        if self.selectedPeriod == type {
            btn.setTitleColor(.white, for: .normal)
        } else {
            btn.setTitleColor(.lightGray, for: .normal)
        }
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
        self.buttons.append(btn)
        
        return btn
    }
    
    private func createLineView() -> UIView {
        let line = UIView()
        line.backgroundColor = .darkGray
        return line
    }
}

// MARK: - Actions
extension PeriodsView {
    
    @objc private func btnAction(sender: UIButton) {
        self.buttons[self.selectedPeriod.rawValue].setTitleColor(.lightGray, for: .normal)
        sender.setTitleColor(.white, for: .normal)
        let newPeriod = PeriodType(rawValue: sender.tag) ?? .week
        
        if newPeriod.rawValue != self.selectedPeriod.rawValue {
            self.selectedPeriod = newPeriod
            self.delegate?.didSelectPeriod(self.selectedPeriod)
        }
    }
}
