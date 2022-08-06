//
//  CashCategoryViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business
import DesignSystem
import OverlayContainer

/// Default notches for over lay controller
public enum CashCategoryViewNotches: Int, CaseIterable {
  /// When hide
  case hide = 0

  /// When show half
  case medium = 1

  /// When show full
  case full
}

struct CashCategoryStruct { }

final class CashCategoryViewController: UIViewController {
    
  // MARK: - Private property

  private var presenter: CashCategoryPresenterProtocol
  private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.itemSize = .init(width: 100, height: 100)
      layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
      return layout
  }()

  private lazy var collectionView: GradientCollectionView = {
      let collectionView = GradientCollectionView(cells: [CashFlowCategoryCell.self], dataSource: self, delegate: self)
      collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
      collectionView.backgroundColor = .anthracite
      return collectionView
  }()

  private var isOpened: Bool = false

  // MARK: - Internal property

  var cashModel: CashModel?

  var hideViewController: (() -> Void)?

  // MARK: - Init

  init(presenter: CashCategoryPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    createUI()
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    isOpened = true
  }

}

// MARK: - CashCategoryViewProtocol

extension CashCategoryViewController: CashCategoryViewProtocol {

  func dismissViewController() {
    hideViewController?()
  }
}

// MARK: - UICollectionViewDataSource

extension CashCategoryViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.categories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CashFlowCategoryCell = collectionView.dequeueCell(indexPath: indexPath)
    cell.categoryModel = presenter.categories[indexPath.row]
    return cell
  }

}

// MARK: - UICollectionViewDelegate

extension CashCategoryViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cashCategory = presenter.categories[indexPath.row]
    presenter.didSelectCategory(cashCategory)
  }
}

// MARK: - Private

private extension CashCategoryViewController {

  func createUI() {
    view.backgroundColor = .anthracite

    view.roundCorners(corners: [.topLeft, .topRight], radius: 16)

    view.addSubview(collectionView)

    collectionView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  var contentHeight: CGFloat {
    CGFloat(collectionView.intrinsicContentSize.height)
  }

}

// MARK: - OverlayContainerViewControllerDelegate

extension CashCategoryViewController: OverlayContainerViewControllerDelegate {
  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    heightForNotchAt index: Int,
    availableSpace: CGFloat
  ) -> CGFloat {
    switch CashCategoryViewNotches(rawValue: index) {
    case .hide?:
      return 0.0
    case .medium?:
      return UIScreen.main.bounds.height / 2.0
    case .full?:
      let screenHeight = UIScreen.main.bounds.height
      let statusBarHeight = UIApplication.shared.statusBarFrame.height
      return min(screenHeight - statusBarHeight, contentHeight)

    default:
      return 0.0
    }
  }
  public func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
    if contentHeight > (UIScreen.main.bounds.height / 2.0) {
      return CashCategoryViewNotches.allCases.count
    } else {
      return [CashCategoryViewNotches.medium, CashCategoryViewNotches.hide].count
    }
  }
  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    didMoveOverlay overlayViewController: UIViewController,
    toNotchAt index: Int
  ) {
    guard isOpened else { return }
    guard let type = CashCategoryViewNotches(rawValue: index), type == .hide else { return }
    hideViewController?()
  }

  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    scrollViewDrivingOverlay
    overlayViewController: UIViewController
  ) -> UIScrollView? {
    return collectionView
  }
}

extension UIView {

  /// Set corner radius
  ///
  /// - Parameters:
  ///     - corners: Corner position
  ///     - radius: Corner radius
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }

}
