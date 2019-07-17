//
//  CashFlowDetailCollectionView.swift
//  MoneyKeeper
//
//  Created by admin on 17/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailContentStruct
struct CashFlowDetailCollectionStruct {
    static let minimumInteritemSpacing: CGFloat = 8
    static let horizontalMargin: CGFloat = 10
    static var itemSize: CGSize {
        get {
            let minimumInteritemSpacing = CashFlowDetailCollectionStruct.minimumInteritemSpacing * 2
            let horizontalMargin = CashFlowDetailCollectionStruct.horizontalMargin * 2
            let screenWidth = UIScreen.main.bounds.size.width
            let width = screenWidth - horizontalMargin - minimumInteritemSpacing
            let itemWidth = width / 2.0
            return CGSize(width: itemWidth, height: 55)
        }
    }
}

// MARK: - CashFlowDetailCollectionView
class CashFlowDetailCollectionView: UIView {

    private var models = [CashFlowModel]()
    private var collectionView: GradientCollectionView!

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Publics
extension CashFlowDetailCollectionView {
    
    public func displayModels(_ models: [CashFlowModel]) {
        self.models = models
        self.collectionView.reloadDataAndSetGradient()
    }
    
    public func updateStringLocalization() {
        self.collectionView.reloadData()
    }
}

// MARK: - Privates
extension CashFlowDetailCollectionView {
    
    private func createUI() {        
        self.collectionView = GradientCollectionView(cells: [CashFlowDetailCell.self], dataSource: self, delegate: self)
        self.collectionView.backgroundColor = .clear
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CashFlowDetailCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashFlowDetailCell = collectionView.dequeueCell(indexPath: indexPath)
        let model = self.models[indexPath.row]
        cell.display(imageName: model.categoryModel.imageName, price: model.getPriceAsString(numberStyle: .currency), category: model.categoryModel.title.localized())
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowDetailCollectionView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.setTopGradientPoint(scrollView)
        self.collectionView.setBottomGradientPoint(scrollView)
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowDetailCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CashFlowDetailCollectionStruct.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CashFlowDetailCollectionStruct.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CashFlowDetailCollectionStruct.minimumInteritemSpacing
    }
}
