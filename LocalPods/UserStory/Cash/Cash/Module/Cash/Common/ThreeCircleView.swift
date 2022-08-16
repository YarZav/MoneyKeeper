//
//  ThreeCircleView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 22/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - ThreeCircleView

final class ThreeCircleView: UIView {

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
    let firstCircle = createCircle(radius: firstCircleRadius, color: firstColor)
    let secondCircle = createCircle(radius: secondCircleRadius, color: secondColor)
    let thirdCircle = createCircle(radius: thirdCircleRadius, color: thirdColor)

    addSubview(firstCircle)
    firstCircle.addSubview(secondCircle)
    addSubview(thirdCircle)

    firstCircle.translatesAutoresizingMaskIntoConstraints = false
    secondCircle.translatesAutoresizingMaskIntoConstraints = false
    thirdCircle.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      firstCircle.topAnchor.constraint(equalTo: topAnchor, constant: firstCircleTopToffset),
      firstCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: firstCircleLeftffset),
      firstCircle.widthAnchor.constraint(equalToConstant: firstCircleRadius * 2),
      firstCircle.heightAnchor.constraint(equalToConstant: firstCircleRadius * 2),

      secondCircle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: secondCircleBottomOffset),
      secondCircle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: secondCircleCentralXOffset),
      secondCircle.widthAnchor.constraint(equalToConstant: secondCircleRadius * 2),
      secondCircle.heightAnchor.constraint(equalToConstant: secondCircleRadius * 2),

      thirdCircle.topAnchor.constraint(equalTo: topAnchor, constant: thirdCircleTopOffset),
      thirdCircle.leftAnchor.constraint(equalTo: leftAnchor, constant: thirdCircleLeftOffset),
      thirdCircle.widthAnchor.constraint(equalToConstant: thirdCircleRadius * 2),
      thirdCircle.heightAnchor.constraint(equalToConstant: thirdCircleRadius * 2)
    ])
  }

  func createCircle(radius: CGFloat, color: UIColor) -> UIView {
    let view = UIView()
    view.cornerRadius(radius, color: color)
    return view
  }

}

// MARK: - First circle

private extension ThreeCircleView {

  var firstCircleRadius: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1,
         .iPhone_6_7_8_SE2_SE3,
         .iPhone_6_7_8_Plus:
      return 200
    case .iPhone_X_Xs_11Pro_12Mini_13Mini,
         .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro,
         .iPhone_12ProMax_13ProMax:
      return 248
    }
  }

  var firstCircleTopToffset: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1,
         .iPhone_6_7_8_SE2_SE3,
         .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro,
         .iPhone_12ProMax_13ProMax,
         .iPhone_6_7_8_Plus:
      return -305
    case .iPhone_X_Xs_11Pro_12Mini_13Mini:
      return -325
    }
  }

  var firstCircleLeftffset: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1,
         .iPhone_6_7_8_SE2_SE3:
      return -61
    case .iPhone_6_7_8_Plus,
         .iPhone_X_Xs_11Pro_12Mini_13Mini,
         .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro,
         .iPhone_12ProMax_13ProMax:
      return -91
    }
  }

}

// MARK: - Second circle

private extension ThreeCircleView {

  var secondCircleRadius: CGFloat {
    175
  }

  var secondCircleCentralXOffset: CGFloat {
    50
  }

  var secondCircleBottomOffset: CGFloat {
    70
  }

}

// MARK: - Third circle

private extension ThreeCircleView {

  var thirdCircleRadius: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1,
         .iPhone_6_7_8_SE2_SE3:
      return 178
    case .iPhone_6_7_8_Plus,
         .iPhone_X_Xs_11Pro_12Mini_13Mini,
         .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro,
         .iPhone_12ProMax_13ProMax:
      return 208
    }
  }

  var thirdCircleLeftOffset: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1:
      return 15
    case .iPhone_6_7_8_SE2_SE3,
         .iPhone_6_7_8_Plus,
         .iPhone_X_Xs_11Pro_12Mini_13Mini,
         .iPhone_12ProMax_13ProMax:
      return 30
    case .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro:
      return -71
    }
  }

  var thirdCircleTopOffset: CGFloat {
    guard let deviceType = UIDevice.current.type else {
      fatalError("Unavailable device")
    }
    switch deviceType {
    case .iPhone_5S_SE1,
         .iPhone_6_7_8_SE2_SE3,
         .iPhone_X_Xs_11Pro_12Mini_13Mini,
         .iPhone_Xr_XsMax_11_11ProMax,
         .iPhone_12_12Pro_13_13Pro,
         .iPhone_12ProMax_13ProMax:
      return -254
    case .iPhone_6_7_8_Plus:
      return -280
    }
  }

}
