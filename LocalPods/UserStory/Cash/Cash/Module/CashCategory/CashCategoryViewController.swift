//
//  CashCategoryViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import Service
import DesignSystem
import OverlayContainer

/// Default notches for over lay controller
private enum CashCategoryViewNotches: Int, CaseIterable {

  /// When hide
  case hide = 0

  /// When show half
  case medium = 1

  /// When show full
  case full

}

final class CashCategoryViewController: UIViewController, CashCategoryProtocol {

  // MARK: - Constants

  private enum Constants {
    static let itemSize: CGSize = .init(width: 100, height: 100)
  }

  // MARK: - CashCategoryProtocol

  var cashModel: CashModel?
  var isOpened: Bool = false
  var completion: (() -> Void)?
  var hide: (() -> Void)?
  
    
  // MARK: - Private property

  private var presenter: CashCategoryPresenterProtocol

  private lazy var searchBar: SearchBar = {
    let searchBar = SearchBar(backgroundColor: .anthracite)
    searchBar.backgroundColor = .anthracite
    searchBar.barTintColor = .anthracite
    searchBar.searchDelegate = self
    return searchBar
  }()

  private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
    let margin: CGFloat = DesignConstants.Margin.plain
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = Constants.itemSize
    layout.sectionInset = .init(top: margin, left: margin, bottom: margin, right: margin)
    return layout
  }()

  private lazy var collectionView: GradientCollectionView = {
      let collectionView = GradientCollectionView(cells: [CashFlowCategoryCell.self], dataSource: self, delegate: self)
      collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
      collectionView.backgroundColor = .anthracite
      return collectionView
  }()

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
    presenter.searchCategory(by: "")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    isOpened = true
  }

}

// MARK: - CashCategoryViewProtocol

extension CashCategoryViewController: CashCategoryViewProtocol {

  func reloadData() {
    collectionView.reloadDataAndSetGradient()
  }

  func didComplete() {
    completion?()
  }
}

// MARK: - UICollectionViewDataSource

extension CashCategoryViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.displayedCategories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CashFlowCategoryCell = collectionView.dequeueCell(indexPath: indexPath)
    cell.categoryModel = presenter.displayedCategories[indexPath.row]
    return cell
  }

}

// MARK: - UICollectionViewDelegate

extension CashCategoryViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cashCategory = presenter.displayedCategories[indexPath.row]
    presenter.didSelectCategory(cashCategory, for: cashModel)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    collectionView.setTopGradientPoint(scrollView)
    collectionView.setBottomGradientPoint(scrollView)
  }

}

// MARK: - Private

private extension CashCategoryViewController {

  func createUI() {
    view.backgroundColor = .anthracite
    view.roundCorners(corners: [.topLeft, .topRight], radius: DesignConstants.Radius.plain)

    view.addSubview(searchBar)
    view.addSubview(collectionView)

    searchBar.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

      collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    guard let type = CashCategoryViewNotches(rawValue: index) else {
      fatalError("Unavailable notch type for CashCategoryViewController")
    }
    switch type {
    case .hide:
      return 0.0
    case .medium:
      return UIScreen.main.bounds.height / 2.0
    case .full:
      let screenHeight = UIScreen.main.bounds.height
      let statusBarHeight = UIApplication.shared.statusBarFrame.height
      return min(screenHeight - statusBarHeight, contentHeight)
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
    guard let type = CashCategoryViewNotches(rawValue: index) else {
      fatalError("Unavailable notch type for CashCategoryViewController")
    }
    switch type {
    case .hide:
      guard isOpened else { return }
      hide?()
    case .medium, .full:
      break
    }
  }

  public func overlayContainerViewController(
    _ containerViewController: OverlayContainerViewController,
    scrollViewDrivingOverlay
    overlayViewController: UIViewController
  ) -> UIScrollView? {
    collectionView
  }
}

// MARK: - SearchBarDelegate

extension CashCategoryViewController: SearchBarDelegate {

  func search(by text: String) {
    presenter.searchCategory(by: text)
  }

}
