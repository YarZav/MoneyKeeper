////
////  GradientView.swift
////  MoneyKeeper
////
////  Created by admin on 05/06/2019.
////  Copyright © 2019 ZYG. All rights reserved.
////
//
//import UIKit
//
//// MARK: - GradientView
//class GradientView: UIView {
//
//    /// Start location of gradient
//    var startColor:   UIColor = .black { didSet { self.updateColors() }}
//
//    /// End location of gradient
//    var endColor:     UIColor = .white { didSet { self.updateColors() }}
//
//    /// Start color of gradient
//    var startLocation: Double =   0.05 { didSet { self.updateLocations() }}
//
//    /// End color of gradient
//    var endLocation:   Double =   0.95 { didSet { self.updateLocations() }}
//
//    override public class var layerClass: AnyClass { return CAGradientLayer.self }
//
//    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
//
//    private func updatePoints() {
//        self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
//        self.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
//    }
//
//    private func updateLocations() {
//        self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
//    }
//
//    private func updateColors() {
//        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
//    }
//
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        self.updatePoints()
//        self.updateLocations()
//        self.updateColors()
//    }
//}
