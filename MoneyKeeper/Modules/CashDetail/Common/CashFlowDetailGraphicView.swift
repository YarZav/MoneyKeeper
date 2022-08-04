//
//  CashFlowDetailGraphicView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZBarChart

// MARK: - CashFlowDetailGraphicView
class CashFlowDetailGraphicView: UIView {
    
    //Properties
    private var barChartView: YZBarChartView!

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Publics
extension CashFlowDetailGraphicView {
    
    public func displayBarViewModels(_ viewModels: [YZBarViewModel]) {
        self.barChartView.displayViewModels(viewModels, animated: true)
    }
}

// MARK: - Privates
extension CashFlowDetailGraphicView {
    
    private func createUI() {
        var configuration = YZBarChartViewConfiguration()
        configuration.separateLineColor = .blueGray
        self.barChartView = YZBarChartView(configuration: configuration)
        self.addSubview(self.barChartView)
        self.barChartView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
}
