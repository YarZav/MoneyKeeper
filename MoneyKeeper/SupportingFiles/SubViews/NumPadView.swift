//
//  NumPadView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 11.10.2018.
//  Copyright © 2018 ZYG. All rights reserved.
//

import UIKit

// MARK: - NumPadViewDelegate
protocol NumPadViewDelegate: class {
    func numberAction(number: String)       // Tap number
    func pointAction(_ point: String)       // Tap decimal separate point
    func deleteAction()                     // Tap delete
}

// MARK: - NumPadViewStruct
struct NumPadViewStruct {
    var viewColor: UIColor = .white             // Background color
    var borderColor: UIColor = .black           // button border color
    var buttonColor: UIColor = .white           // Button background color
    var textColor: UIColor = .black             // Button text color
    var horizontalSpacing: CGFloat = 8.0        // Horizontal spasing bweetn button
    var verticalSpacing: CGFloat = 8.0          // Vertical spacing between button
    var buttonRadius: CGFloat = 35              // Button button radius
    var textSize: CGFloat = 17                  // Text size in button
    var deleteIcon: String = ""                 // Delete icon for button
}

// MARK: - NumPadView
class NumPadView: UIView {
    
    //Properties
    public weak var delegate: NumPadViewDelegate?
    public var viewStruct = NumPadViewStruct()
    private var numTag = 1

    //Init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(viewStruct: NumPadViewStruct) {
        super.init(frame: .zero)
        self.viewStruct = viewStruct
        self.createUI()
    }
}

// MARK: - Actions
extension NumPadView {
    
    @objc func roundButtonAction(sender: UIButton) {
        switch sender.tag {
        case 10:        self.delegate?.pointAction(".")
        case 11:        self.delegate?.deleteAction()
        case 0...9:    self.delegate?.numberAction(number:  "\(sender.tag)")
        default:        break
        }
    }
}

// MARK: - Privates
extension NumPadView {
    
    private func createUI() {
        self.backgroundColor = self.viewStruct.viewColor
        
        let stackView = self.createStackView(axis: .vertical, spacing: self.viewStruct.verticalSpacing)
        for _ in 0..<3 {
            let horizontalStackView = self.createButtonsStackView(buttonCount: 3)
            stackView.addArrangedSubview(horizontalStackView)
        }
        
        let pointZeroDeleteStackView = self.createPointDeleteZeroStackView()
        stackView.addArrangedSubview(pointZeroDeleteStackView)
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func createButtonsStackView(buttonCount: Int) -> UIStackView {
        let stackView = self.createStackView(axis: .horizontal, spacing: self.viewStruct.horizontalSpacing)
        for _ in 0..<buttonCount {
            let numButton = self.createRoundButton(title: "\(self.numTag)", tag: self.numTag)
            self.numTag += 1
            stackView.addArrangedSubview(numButton)
        }

        return stackView
    }
    
    private func createStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    //FIXME: "." point should be based on device language
    private func createPointDeleteZeroStackView() -> UIStackView {
        let stackView = self.createStackView(axis: .horizontal, spacing: self.viewStruct.horizontalSpacing)
        stackView.addArrangedSubview(self.createRoundButton(title: ".", tag: 10))
        stackView.addArrangedSubview(self.createRoundButton(title: "0", tag: 0))
        stackView.addArrangedSubview(self.createRoundButton(imageName: self.viewStruct.deleteIcon, tag: 11))
        
        return stackView
    }
    
    private func createRoundButton(title: String, tag: Int) -> UIButton {
        let roundButton = HightLightRoundButton(backgroundColor: self.viewStruct.buttonColor, radius: self.viewStruct.buttonRadius, borderColor: self.viewStruct.borderColor)
        roundButton.addTarget(self, action: #selector(roundButtonAction), for: .touchUpInside)
        roundButton.tag = tag
        roundButton.setTitle(title, for: .normal)
        roundButton.setTitleColor(self.viewStruct.textColor, for: .normal)
        roundButton.titleLabel?.font = UIFont.systemFont(ofSize: self.viewStruct.textSize)

        return roundButton
    }
    
    private func createRoundButton(imageName: String, tag: Int) -> UIButton {
        let roundButton = HightLightRoundButton(backgroundColor: self.viewStruct.buttonColor, radius: self.viewStruct.buttonRadius, borderColor: self.viewStruct.borderColor)
        roundButton.addTarget(self, action: #selector(roundButtonAction), for: .touchUpInside)
        roundButton.tag = tag
        roundButton.setImage(UIImage(named: imageName), for: .normal)
        roundButton.imageView?.contentMode = .scaleAspectFit
        
        return roundButton
    }
}
