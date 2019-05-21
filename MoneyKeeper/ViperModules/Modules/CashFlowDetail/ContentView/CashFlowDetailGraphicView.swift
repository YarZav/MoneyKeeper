//
//  CashFlowDetailGraphicView.swift
//  MoneyKeeper
//
//  Created by admin on 08.04.2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit

// MARK: - CashFlowDetailContentStruct
struct CashFlowDetailGraphicContentStruct {
    static let minimumInteritemSpacing: CGFloat = 8
    static let horizontalMargin: CGFloat = 10
    static var itemSize: CGSize {
        get {
            let minimumInteritemSpacing = CashFlowDetailGraphicContentStruct.minimumInteritemSpacing * 2
            let horizontalMargin = CashFlowDetailGraphicContentStruct.horizontalMargin * 2
            let screenWidth = UIScreen.main.bounds.size.width
            let width = screenWidth - horizontalMargin - minimumInteritemSpacing
            let itemWidth = width / 2.0
            return CGSize(width: itemWidth, height: 55)
        }
    }
}

// MARK: - CashFlowDetailGraphicView
class CashFlowDetailGraphicView: UIView {
    
    //Properties
    private var models = [CashFlowModel]()
    private var graphicView: GraphicView!
    private var collectionView: GradientCollectionView!

    //Init
    init() {
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Publics
extension CashFlowDetailGraphicView {
    
    public func displayBarViewModels(_ models: [BarViewModel]) {
        self.graphicView.displayModels(models)
    }
    
    public func displayModels(_ models: [CashFlowModel]) {
        self.models = models
        UIView.animate(withDuration: 0, animations: {
            self.collectionView.reloadData()
        }) { (finished) in
            if finished {
                self.scrollViewDidScroll(self.collectionView)
            }
        }
    }
}

// MARK: - Privates
extension CashFlowDetailGraphicView {
    
    private func createUI() {
        self.graphicView = GraphicView()
        self.addSubview(self.graphicView)
        self.graphicView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(250)
        }
        
        self.collectionView = GradientCollectionView(cells: [CashFlowDetailCell.self], dataSource: self, delegate: self)
        self.collectionView.backgroundColor = .clear
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.graphicView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CashFlowDetailGraphicView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashFlowDetailCell = collectionView.dequeueCell(indexPath: indexPath)
        let model = self.models[indexPath.row]
        cell.display(imageName: model.serviceModel.imageName, price: model.getPriceAsString(numberStyle: .currency), category: model.serviceModel.title)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowDetailGraphicView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.setTopGradientPoint(scrollView)
        self.collectionView.setBottomGradientPoint(scrollView)
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowDetailGraphicView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CashFlowDetailGraphicContentStruct.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CashFlowDetailGraphicContentStruct.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CashFlowDetailGraphicContentStruct.minimumInteritemSpacing
    }
}
