//
//  AddCashNumPadView.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import YZNumPad

protocol AddCashNumPadDelegate: AnyObject {

  func setPrice(_ price: String?)

}

// MARK: - AddCashNumPadStruct

private struct AddCashNumPadStruct {

  static var horizontalSpacing: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE?:
        return 30
      case .iPhone_6_7_8?:
        return 43
      case .iPhone_6_7_8_Plus?:
        return 43
      case .iPhone_X_Xs_11Pro?:
        return 50
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 50
      default:
        return 0
      }
    }
  }
  
  static var verticalSpacing: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE?:
        return 10
      case .iPhone_6_7_8?:
        return 20
      case .iPhone_6_7_8_Plus?:
        return 25
      case .iPhone_X_Xs_11Pro?:
        return 25
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 25
      default:
        return 0
      }
    }
  }
  
  static var buttonRadius: CGFloat {
    get {
      switch UIDevice.current.type {
      case .iPhone_5S_SE?:
        return 29
      case .iPhone_6_7_8?:
        return 29
      case .iPhone_6_7_8_Plus?:
        return 35
      case .iPhone_X_Xs_11Pro?:
        return 35
      case .iPhone_Xr_XsMax_11_11ProMax?:
        return 35
      default:
        return 0
      }
    }
  }

}

final class AddCashNumPadView: UIView {

  // MARK: - Constants

  private enum Constants {
      static let deleteImage = UIImage(named: "DeleteSymbol")
  }

  // MARK: - Private property

  private var priceLengthLimit: Int = 0
  private var price: String = ""
  private var point: String?

  private lazy var numPadView: YZNumPadView = {
    let view = YZNumPadView(config: getNumPadConfig())
    view.delegate = self
    return view
  }()

  // MARK: - Internal

  weak var delegate: AddCashNumPadDelegate?

  // MARK: - Init

  override private init(frame: CGRect) {
    super.init(frame: frame)
  }

  init(priceLengthLimit: Int) {
    super.init(frame: .zero)
    self.priceLengthLimit = priceLengthLimit
    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

// MARK: - Internal

extension AddCashNumPadView {

  func dropPrice() {
    price = ""
    delegate?.setPrice(price)
  }

}

// MARK: - Private

private extension AddCashNumPadView {

  func createUI() {
    addSubview(numPadView)

    numPadView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      numPadView.topAnchor.constraint(equalTo: topAnchor),
      numPadView.leftAnchor.constraint(equalTo: leftAnchor),
      numPadView.rightAnchor.constraint(equalTo: rightAnchor),
      numPadView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func getNumPadConfig() -> YZNumPadViewConfiguration {
    var numPadViewStruct = YZNumPadViewConfiguration()
    numPadViewStruct.viewColor = .anthracite
    numPadViewStruct.borderColor = .darkViolet
    numPadViewStruct.buttonColor = .anthracite
    numPadViewStruct.textColor = .white
    numPadViewStruct.horizontalSpacing = AddCashNumPadStruct.horizontalSpacing
    numPadViewStruct.verticalSpacing = AddCashNumPadStruct.verticalSpacing
    numPadViewStruct.buttonRadius = AddCashNumPadStruct.buttonRadius
    numPadViewStruct.textSize = 36
    numPadViewStruct.deleteIcon = Constants.deleteImage
    return numPadViewStruct
  }

}

// MARK: - YZNumPadViewDelegate
extension AddCashNumPadView: YZNumPadViewDelegate {
  
  func didTapNumber(_ number: Int, numPadView: YZNumPadView) {
    guard price.count <= priceLengthLimit else { return }
    price.addNumberToPriceString(number, pointSymbol: point)
    delegate?.setPrice(price)
  }
  
  func didTapDecimapSeparator(_ decimapSeparator: String?, numPadView: YZNumPadView) {
    guard let decimapSeparator = decimapSeparator else { return }
    point = decimapSeparator
    
    guard price.count <= priceLengthLimit else { return }
    price.addDecimalSeparator(decimapSeparator)
    delegate?.setPrice(price)
  }
  
  func didTapDelete(numPadView: YZNumPadView) {
    price.deleteLastCharacter()
    delegate?.setPrice(price)
  }

}
