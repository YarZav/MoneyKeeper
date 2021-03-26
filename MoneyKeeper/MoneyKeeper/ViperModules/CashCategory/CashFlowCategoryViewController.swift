//
//  CashFlowCategoryViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit
import YZNotificationView

// MARK: - CashFlowViewStruct
struct CashFlowCategoryStruct {
    static let minimumInteritemSpacing: CGFloat = 8
    static let horizontalMargin: CGFloat = 24
    static var itemSize: CGSize {
        get {
            let minimumInteritemSpacing = CashFlowCategoryStruct.minimumInteritemSpacing * 2
            let horizontalMargin = CashFlowCategoryStruct.horizontalMargin * 2
            let screenWidth = UIScreen.main.bounds.size.width
            let width = screenWidth - horizontalMargin - minimumInteritemSpacing
            let itemWidth = width / 3.0
            return CGSize(width: itemWidth, height: 92)
        }
    }
}


// MARK: - CashFlowCategoryViewController
class CashFlowCategoryViewController: BaseViewController {
    
    //Properties
    public var presenter: CashFlowCategoryPresenterProtocol!
    public var model: CashModel!
    
    private let transition = CashFlowCategoryTransitionDelegate()
    private var price = MarginLabel(font: UIFont.systemFont(ofSize: 15), textAlignment: .center)
    private var collectionView: GradientCollectionView!
    private var priceLabel = UILabel(font: UIFont.systemFont(ofSize: 18), textColor: .white, textAlignment: .center)
    private var items = [CategoryModel]()
    private var totalPrice: String?
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad(type: self.model.type)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.price.text = self.model.getPriceAsString(numberStyle: .currency)
    }
}

// MARK: - CashFlowCategoryViewControllerProtocol
extension CashFlowCategoryViewController: CashFlowCategoryViewControllerProtocol {
    
    func updateStringLocalization() {
        self.navigationItem.title = "CashFlowCategoryTitle".localized()
        self.collectionView.reloadData()
        self.setTotalPrice(self.totalPrice)
    }
    
    func setTotalPrice(_ total: String?) {
        self.totalPrice = total
        self.priceLabel.text = "CashFlowCategoryTotal".localized() + ": " + (self.totalPrice ?? "")
    }
    
    func setItems(_ items: [CategoryModel]) {
        self.items = items
        self.collectionView.reloadDataAndSetGradient()
    }
    
    func deleteItems(_ items: [CategoryModel]) {
        var deletedIndexes = [IndexPath]()
        items.forEach { (deleltedItem) in
            if let rowIndex = self.items.firstIndex(where: { (currentItem) -> Bool in deleltedItem.id == currentItem.id }) {
                deletedIndexes.append(IndexPath(row: rowIndex, section: 0))
                self.items.remove(at: rowIndex)
            }
        }
        self.collectionView.deleteItems(at: deletedIndexes)
    }
    
    func insertItems(_ items: [CategoryModel]) {
        var insertedIndexes = [IndexPath]()
        items.forEach {
            insertedIndexes.append(IndexPath(row: self.items.count, section: 0))
            self.items.append($0)
        }
        self.collectionView.insertItems(at: insertedIndexes)
    }
}

// MARK: - Actions
extension CashFlowCategoryViewController {
    
    @objc private func addAction() {
        self.presenter.presentAddCategory()
    }
}

// MARK: - Privates
extension CashFlowCategoryViewController {
    
    private func createUI() {
//        let margin = CashFlowCategoryStruct.horizontalMargin
        self.view.backgroundColor = .anthracite
        self.navigationItem.title = "CashFlowCategoryTitle".localized()
        
        let image = UIImage(named: "WhiteAdd")?.resizeImage(30, opaque: false).withRenderingMode(.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.price.cornerRadius(13, color: .white)
        
        self.collectionView = GradientCollectionView(cells: [CashFlowCategoryCell.self], dataSource: self, delegate: self)
        self.collectionView.backgroundColor = UIColor.anthracite
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.priceLabel.cornerRadius(15, color: UIColor.darkViolet.withAlphaComponent(0.5))
        
        self.view.addSubview(self.price)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.priceLabel)
        
//        self.price.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(self.getNavigationbarHeight() + margin)
//            $0.left.equalToSuperview().offset(margin)
//            $0.right.equalToSuperview().offset(-margin)
//            $0.height.equalTo(36)
//        }
//        
//        self.collectionView.snp.makeConstraints {
//            $0.top.equalTo(self.price.snp.bottom).offset(margin)
//            $0.left.equalToSuperview().offset(margin)
//            $0.right.equalToSuperview().offset(-margin)
//        }
//        
//        self.priceLabel.snp.makeConstraints {
//            $0.top.equalTo(self.collectionView.snp.bottom).offset(21)
//            $0.left.equalToSuperview().offset(16)
//            $0.right.equalToSuperview().offset(-16)
//            $0.height.equalTo(44)
//            $0.bottom.equalToSuperview().offset(-self.getTabBarHeight()-margin)
//        }
    }
    
    private func getCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashFlowCategoryCell = collectionView.dequeueCell(indexPath: indexPath)
        let item = self.items[indexPath.row]
        cell.display(title: item.title, icon: item.imageName)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension CashFlowCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.getCell(for: collectionView, indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.model.categoryModel = self.items[indexPath.row]
        self.presenter.saveCashFlowModel(self.model)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.setTopGradientPoint(scrollView)
        self.collectionView.setBottomGradientPoint(scrollView)
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CashFlowCategoryStruct.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CashFlowCategoryStruct.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CashFlowCategoryStruct.minimumInteritemSpacing
    }
}

// MARK: - CashFlowCategoryCellDelegate
extension CashFlowCategoryViewController: CashFlowCategoryCellDelegate {
    
    func longPress(_ cell: CashFlowCategoryCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        
        let attributes = self.collectionView.layoutAttributesForItem(at: indexPath)
        let attributesFrame = attributes?.frame ?? .zero
        let frameToOpenFrom = collectionView.convert(attributesFrame, to: self.collectionView.superview)
        
        self.transition.openingFrame = frameToOpenFrom
        self.transition.model = self.items[indexPath.row]
        self.transitioningDelegate = self.transition
        
        self.presenter.presentCashFlowDetailCategory(transition: self.transition)
    }
}
