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

  // MARK: - Internal property

  var cashModel: CashModel?

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

}

// MARK: - CashCategoryViewProtocol

extension CashCategoryViewController: CashCategoryViewProtocol { }

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

    view.addSubview(collectionView)

    collectionView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

}
