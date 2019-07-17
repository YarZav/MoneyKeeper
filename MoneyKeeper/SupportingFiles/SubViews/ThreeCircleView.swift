//
//  ThreeCircleView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 22/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - ThreeCircleView
class ThreeCircleView: UIView {
    
    private var firstColor: UIColor = .white
    private var secondColor: UIColor = .white
    private var thirdColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(first: UIColor, second: UIColor, third: UIColor) {
        self.firstColor = first
        self.secondColor = second
        self.thirdColor = third

        super.init(frame: .zero)
        self.createUI()
    }
}

// MARK: - Privates
extension ThreeCircleView {
    
    private func createUI() {
        let firstCircle = self.createCircle(radius: 248, color: self.firstColor)
        let secondCircle = self.createCircle(radius: 175, color: self.secondColor)
        let thirdCircle = self.createCircle(radius: 178, color: self.thirdColor)

        self.addSubview(firstCircle)
        firstCircle.addSubview(secondCircle)
        self.addSubview(thirdCircle)

        firstCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-325)
            $0.left.equalToSuperview().offset(-91)
            $0.width.equalTo(496)
            $0.height.equalTo(496)
        }
        
        secondCircle.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(70)
            $0.centerX.equalToSuperview().offset(-10)
            $0.width.equalTo(350)
            $0.height.equalTo(350)
        }
        
        thirdCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-214)
            $0.left.equalToSuperview().offset(-71)
            $0.width.equalTo(356)
            $0.height.equalTo(356)
        }
    }
    
    private func createCircle(radius: CGFloat, color: UIColor) -> UIView {
        let view = UIView()
        view.cornerRadius(radius, color: color)
        return view
    }
}
