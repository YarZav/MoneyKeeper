//
//  ThreeCircleView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 22/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Extension

// MARK: - ThreeCircleView

final class ThreeCircleView: UIView {

  // MARK: - Constants

  private enum Constants {
    static let firstCircleRadius: CGFloat = 248
    static let firstCircleTopToffset: CGFloat = -225
    static let firstCircleLeftffset: CGFloat = -91
    static let secondCircleRadius: CGFloat = 175
    static let secondCircleBottomOffset: CGFloat = 70
    static let secondCircleCentralXOffset: CGFloat = 50
    static let thirdCircleRadius: CGFloat = 178
    static let thirdCircleTopOffset: CGFloat = -214
    static let thirdCircleLeftOffset: CGFloat = -71
  }

  // MARK: - Private property

  private var firstColor: UIColor = .white
  private var secondColor: UIColor = .white
  private var thirdColor: UIColor = .white

  // MARK: - Init

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

    createUI()
  }

}

// MARK: - Privates
private extension ThreeCircleView {

  func createUI() {
    let firstCircle = createCircle(radius: Constants.firstCircleRadius, color: firstColor)
    let secondCircle = createCircle(radius: Constants.secondCircleRadius, color: secondColor)
    let thirdCircle = createCircle(radius: Constants.thirdCircleRadius, color: thirdColor)

    addSubview(firstCircle)
    firstCircle.addSubview(secondCircle)
    addSubview(thirdCircle)

    firstCircle.translatesAutoresizingMaskIntoConstraints = false
    secondCircle.translatesAutoresizingMaskIntoConstraints = false
    thirdCircle.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      firstCircle.topAnchor.constraint(equalTo: topAnchor, constant: Constants.firstCircleTopToffset),
      firstCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.firstCircleLeftffset),
      firstCircle.widthAnchor.constraint(equalToConstant: Constants.firstCircleRadius * 2),
      firstCircle.heightAnchor.constraint(equalToConstant: Constants.firstCircleRadius * 2),

      secondCircle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.secondCircleBottomOffset),
      secondCircle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: Constants.secondCircleCentralXOffset),
      secondCircle.widthAnchor.constraint(equalToConstant: Constants.secondCircleRadius * 2),
      secondCircle.heightAnchor.constraint(equalToConstant: Constants.secondCircleRadius * 2),

      thirdCircle.topAnchor.constraint(equalTo: topAnchor, constant: Constants.thirdCircleTopOffset),
      thirdCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.thirdCircleLeftOffset),
      thirdCircle.widthAnchor.constraint(equalToConstant: Constants.thirdCircleRadius * 2),
      thirdCircle.heightAnchor.constraint(equalToConstant: Constants.thirdCircleRadius * 2)
    ])
  }

  func createCircle(radius: CGFloat, color: UIColor) -> UIView {
    let view = UIView()
    view.cornerRadius(radius, color: color)
    return view
  }

}
