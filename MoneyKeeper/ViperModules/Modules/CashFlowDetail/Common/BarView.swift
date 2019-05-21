//
//  BarView.swift
//  MoneyKeeper
//
//  Created by admin on 21.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - BarViewModel
class BarViewModel {
    
    var x: String
    var y: Double
    
    init(x: String, y: Double) {
        self.x = x
        self.y = y
    }
}

// MARK: - BarView
class BarView: UIView {
    
    public var model: BarViewModel?
    private var maxModel: BarViewModel?
    
    public var bar = UIView()
    
    private var animateDuration = TimeInterval(0.3)

    //Init
    init(isLastBar: Bool, model: BarViewModel, maxModel: BarViewModel?) {
        super.init(frame: .zero)
        self.model = model
        self.maxModel = maxModel
        self.createUI(isLastBar: isLastBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Pubilcs
extension BarView {
    
    public func didTouch(_ touched: Bool) {
        if touched {
            self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            self.bar.backgroundColor = .white
        } else {
            self.backgroundColor = .clear
            self.bar.backgroundColor = UIColor(white: 0.8, alpha: 1)
        }
    }
    
    public func showBar(animateion: Bool) {
        var y: Double = 0.0
        if let model = self.model {
            if let maxModel = self.maxModel, maxModel.y != 0 {
                let ratio = 200.0 / maxModel.y
                y = ratio * (model.y)
            }
        }
        
        self.setNeedsLayout()
        UIView.animate(withDuration: animateion ? self.animateDuration : 0) {
            self.bar.snp.updateConstraints({
                $0.height.equalTo(y)
            })
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Privates
extension BarView {
    
    private func createUI(isLastBar: Bool) {
        self.bar.backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        let leftLine = UIView()
        leftLine.backgroundColor = .darkGray
        
        self.addSubview(leftLine)
        self.addSubview(self.bar)

        leftLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(1)
        }
        
        if isLastBar {
            let leftLine = UIView()
            leftLine.backgroundColor = .darkGray
            
            self.addSubview(leftLine)
            
            leftLine.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.right.equalToSuperview()
                $0.width.equalTo(1)
            }
        }
        
        self.bar.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-1)
            $0.left.equalToSuperview().offset(1)
            $0.right.equalToSuperview().offset(-1)
            $0.height.equalTo(0)
        }
    }
}
