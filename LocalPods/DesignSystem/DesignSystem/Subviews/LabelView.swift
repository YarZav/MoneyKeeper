//
//  LabelView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

public final class LabelView: UIView {

  // MARK: - Private property

  private lazy var label: UILabel = {
    let font = UIFont.systemFont(ofSize: 17)
    let label = UILabel(font: font, textColor: .white, textAlignment: .center)
    label.numberOfLines = 0
    return label
  }()

  private let labelInsets: UIEdgeInsets

  // MARK: - Init

  public init(labelInsets: UIEdgeInsets = .zero) {
    self.labelInsets = labelInsets

    super.init(frame: .zero)

    createUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - Public

public extension LabelView {

  func setText(_ text: String?) {
    label.text = text
  }

  func setTextColor(_ color: UIColor) {
    label.textColor = color
  }
}

// MARK: - Private

private extension LabelView {

  func createUI() {
    addSubview(label)

    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: labelInsets.top),
      label.leftAnchor.constraint(equalTo: leftAnchor, constant: labelInsets.left),
      label.rightAnchor.constraint(equalTo: rightAnchor, constant: -labelInsets.right),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -labelInsets.bottom),
    ])
  }

}
