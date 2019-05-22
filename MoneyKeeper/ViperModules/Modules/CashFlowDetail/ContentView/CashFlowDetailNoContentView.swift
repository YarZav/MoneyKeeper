//
// CashFlowDetailNoContentView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailNoContentView
class CashFlowDetailNoContentView: UIView {

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates
extension CashFlowDetailNoContentView {
    
    private func createUI() {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Здесь Вы можете увидеть свои расходы или доходы"
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
