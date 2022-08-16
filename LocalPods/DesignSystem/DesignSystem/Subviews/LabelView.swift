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

public extension LabelView {

  func setText(_ text: String?) {
    label.text = text
  }

}

// MARK: - Private

private extension LabelView {

  func createUI() {
    addSubview(label)

    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leftAnchor.constraint(equalTo: leftAnchor),
      label.rightAnchor.constraint(equalTo: rightAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

}
