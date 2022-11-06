//
//  CashDetailMenuViewController.swift
//  Cash
//
//  Created by Yaroslav Zavyalov on 10/30/22.
//

import DesignSystem
import OverlayContainer

/// Default notches for over lay controller
private enum CashDetailMenuViewNotches: Int, CaseIterable {

  /// When hide
  case hide = 0

  /// When show full
  case full

}

final class CashDetailMenuViewController: UIViewController, CashDetailMenuProtocol {

  // MARK: - Constants

  private enum Constants {
    static let title = "Settings".localized()
  }

  // MARK: - Property

  private lazy var titleLabel: UILabel = {
    let label = UILabel(font: .systemFont(ofSize: 17), textAlignment: .center)
    label.text = Constants.title
    return label
  }()

  private lazy var periodSegmentControl: UISegmentedControl = {
    let segmentControl = UISegmentedControl()
    CashDetailPeriodType.allCases.forEach { segmentControl.setTitle($0.title, forSegmentAt: $0.rawValue) }
    return segmentControl
  }()

  var isOpened: Bool = false
  var hide: (() -> Void)?

  //MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    let jsonPath = Bundle.main.path(forResource: "inception", ofType: "json")
    let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath ?? ""), options: .mappedIfSafe)
    let jsonString = try? JSONSerialization.jsonObject(with: jsonData ?? Data(), options: .mutableLeaves)

    createUI()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    isOpened = true
  }

}

// MARK: - Private

private extension CashDetailMenuViewController {

  func createUI() {
    view.backgroundColor = .blueGray
    view.roundCorners(corners: [.topLeft, .topRight], radius: DesignConstants.Radius.plain)

    view.addSubview(titleLabel)
    view.addSubview(periodSegmentControl)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    periodSegmentControl.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: DesignConstants.Radius.plain),
      titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: DesignConstants.Margin.plain),
      titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -DesignConstants.Margin.plain),

      periodSegmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DesignConstants.Radius.plain),
      periodSegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: DesignConstants.Margin.plain),
      periodSegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -DesignConstants.Margin.plain),
    ])
  }

}

// MARK: - CashDetailMenuViewProtocol

extension CashDetailMenuViewController: CashDetailMenuViewProtocol { }

// MARK: - OverlayContainerViewControllerDelegate

extension CashDetailMenuViewController: OverlayContainerViewControllerDelegate {
  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    heightForNotchAt index: Int,
    availableSpace: CGFloat
  ) -> CGFloat {
    guard let type = CashDetailMenuViewNotches(rawValue: index) else {
      fatalError("Unavailable notch type for CashDetailMenuViewNotches")
    }
    switch type {
    case .hide:
      return 0.0
    case .full:
      return UIScreen.main.bounds.height / 2.0
    }
  }

  public func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
    [CashDetailMenuViewNotches.full, CashDetailMenuViewNotches.hide].count
  }

  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    didMoveOverlay overlayViewController: UIViewController,
    toNotchAt index: Int
  ) {
    guard let type = CashDetailMenuViewNotches(rawValue: index) else {
      fatalError("Unavailable notch type for CashDetailMenuViewNotches")
    }
    switch type {
    case .hide:
      guard isOpened else { return }
      hide?()
    case .full:
      break
    }
  }

  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    scrollViewDrivingOverlay
    overlayViewController: UIViewController
  ) -> UIScrollView? {
    nil
  }
}

