//
//  HeaderView.swift
//  MoneyKeeper
//
//  Created by admin on 17/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public final class HeaderView: UIView {

  // MARK: - Private

  private let textLabel = UILabel(font: UIFont.systemFont(ofSize: 17))
  private lazy var separateLineView: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()

  // MARK: - Init

  public init() {
    super.init(frame: .zero)

    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}

// MARK: - Public
public extension HeaderView {
    
  func updateTextColor(_ color: UIColor) {
    textLabel.textColor = color
  }
  
  func updateText(_ text: String?) {
    textLabel.text = text
  }

}

// MARK: - Privates

private extension HeaderView {

  func createUI() {
    addSubview(textLabel)
    addSubview(separateLineView)

    textLabel.translatesAutoresizingMaskIntoConstraints = false
    separateLineView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: topAnchor),
      textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      textLabel.rightAnchor.constraint(equalTo: rightAnchor),

      separateLineView.topAnchor.constraint(equalTo: topAnchor),
      separateLineView.leftAnchor.constraint(equalTo: leftAnchor),
      separateLineView.rightAnchor.constraint(equalTo: rightAnchor),
      separateLineView.heightAnchor.constraint(equalToConstant: 1),
    ])
  }

}
