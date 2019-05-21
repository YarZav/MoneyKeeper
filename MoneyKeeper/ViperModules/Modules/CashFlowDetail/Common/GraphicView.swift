//
//  GraphicView.swift
//  MoneyKeeper
//
//  Created by admin on 21.03.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - GraphicView
class GraphicView: UIView {
    
    private var label = UILabel()
    private var barViews = [BarView]()
    private var models = [BarViewModel]()

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            var isContainsbarView: Bool = false
            
            for barView in self.barViews {
                let barFrame = self.convert(barView.frame, from: barView.superview)
                if barFrame.contains(location) {
                    barView.didTouch(true)
                    
                    isContainsbarView = true
                    self.didTouchBarView(barView)
                } else {
                    barView.didTouch(false)
                }
            }
            
            if !isContainsbarView {
                self.didTouchBarView(nil)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for barView in self.barViews {
            barView.didTouch(false)
        }
        
        self.didTouchBarView(nil)
    }
    
    private func didTouchBarView(_ barView: BarView?) {
        if let barView = barView, let model = barView.model {
            let numberFormatter = NumberFormatter.numberFormatter(numberStyle: .currency)
            let number = NSNumber(value: model.y)
            self.label.text = numberFormatter.string(from: number)
        } else {
            self.label.text = nil
        }
    }
}

// MARK: - Publics
extension GraphicView {
    
    public func displayModels(_ models: [BarViewModel]) {
        self.models = models
        
        self.subviews.forEach { $0.removeFromSuperview() }
        self.createUI()
        
        self.layoutIfNeeded()
        
        self.showBar(animateion: true)
    }
    
    public func showBar(animateion: Bool) {
        self.barViews.forEach {
            $0.showBar(animateion: animateion)
        }
    }
}

// MARK: - Privates
extension GraphicView {
    
    private func createUI() {
        self.label = UILabel()
        self.label.textColor = .white
        self.label.textAlignment = .center
        self.label.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(self.label)
        self.label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        let maxModel = self.models.max { $0.y < $1.y }

        let comparison = self.models.count > 10 ? 10 : 1
        let attitude = comparison == 1 ? 1 : self.models.count / comparison
        
        var previousView: BarView?
        var previousDescription: UILabel?
        
        for (modelIndex, model) in self.models.enumerated() {
            let isLastIndex = modelIndex == self.models.count - 1
            
            let barView = BarView(isLastBar: isLastIndex, model: model, maxModel: maxModel)
            barView.tag = modelIndex
            
            self.barViews.append(barView)
            self.addSubview(barView)
            
            barView.snp.makeConstraints {
                $0.top.equalTo(self.label.snp.bottom)
                $0.bottom.equalToSuperview().offset(-20)
                
                if let prevView = previousView {
                    $0.left.equalTo(prevView.snp.right)
                    $0.width.equalTo(prevView)
                } else {
                    $0.left.equalToSuperview()
                }
                
                if isLastIndex {
                    $0.right.equalToSuperview()
                }
            }
            
            previousView = barView
            
            if modelIndex % attitude == 0 {
                let descriptionLabel = UILabel()
                descriptionLabel.textColor = .white
                descriptionLabel.textAlignment = .center
                descriptionLabel.font = UIFont.systemFont(ofSize: 11)
                descriptionLabel.text = model.x
                
                self.addSubview(descriptionLabel)
                
                descriptionLabel.snp.makeConstraints {
                    $0.bottom.equalToSuperview()
                    $0.height.equalTo(20)

                    if let previousDescription = previousDescription {
                        $0.left.equalTo(previousDescription.snp.right)
                        $0.width.equalTo(previousDescription)
                    } else {
                        $0.left.equalToSuperview()
                    }
                    
                    if comparison == 1 {
                        if modelIndex == (self.models.count - 1) {
                            $0.right.equalToSuperview()
                        }
                    } else {
                        if (modelIndex + attitude) == self.models.count {
                            $0.right.equalToSuperview()
                        }
                    }
                }
                
                previousDescription = descriptionLabel
            }
        }
        
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = .darkGray
        
        self.addSubview(bottomLineView)
        
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

