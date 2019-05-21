//
//  CashFlowCategoryViewController.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 20/02/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit

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
    public var model: CashFlowModel!
    
    private let transitionDelegate = CashFlowCategoryTransitionDelegate()
    private var price: MarginLabel!
    private var collectionView: GradientCollectionView!
    private var items = [ServiceModel]()
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.price.text = self.model.getPriceAsString(numberStyle: .currency)
    }
}

// MARK: - CashFlowCategoryViewControllerProtocol
extension CashFlowCategoryViewController: CashFlowCategoryViewControllerProtocol {
    
    func setItems(_ items: [ServiceModel]) {
        self.items = items
        UIView.animate(withDuration: 0, animations: {
            self.collectionView.reloadData()
        }) { (finished) in
            if finished {
                self.scrollViewDidScroll(self.collectionView)
            }
        }
    }
    
    func succedSave() {
        let size: CGFloat = 64.0
        let image = UIImageView(image: UIImage(named: "Success"))
        
        let alert = UIAlertController(title: "Success", message: "\n\n\n", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self] (alertController) in
            self?.dismissAlertViewController(alert)
        })
        
        alert.view.addSubview(image)
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(size)
            $0.height.equalTo(size)
        }
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.dismissAlertViewController(alert)
        }
    }
}

// MARK: - Privates
extension CashFlowCategoryViewController {
    
    private func createUI() {
        let margin = CashFlowCategoryStruct.horizontalMargin
        self.view.backgroundColor = UIColor.anthracite
        self.navigationItem.title = "Категории"
        
        self.price = MarginLabel()
        self.price.textAlignment = .center
        self.price.font = UIFont.systemFont(ofSize: 18)
        self.price.backgroundColor = .white
        self.price.layer.masksToBounds = true
        self.price.layer.cornerRadius = 13
        
        self.collectionView = GradientCollectionView(cells: [CashFlowCategoryCell.self], dataSource: self, delegate: self)
        self.collectionView.backgroundColor = UIColor.anthracite
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(self.price)
        self.view.addSubview(self.collectionView)
        
        self.price.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.getNavigationbarHeight() + margin)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.height.equalTo(36)
        }
        
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.price.snp.bottom).offset(margin)
            $0.left.equalToSuperview().offset(margin)
            $0.right.equalToSuperview().offset(-margin)
            $0.bottom.equalToSuperview().offset(-self.getTabBarHeight()-margin)
        }
    }
    
    private func dismissAlertViewController(_ alert: UIAlertController) {
        guard self.presentedViewController == alert else { return }
        self.dismiss(animated: true) {
            self.presenter.popViewController()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CashFlowCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashFlowCategoryCell = collectionView.dequeueCell(indexPath: indexPath)
        let item = self.items[indexPath.row]
        cell.display(title: item.title, icon: item.imageName, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        self.model.serviceModel = item

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
    
    func longPress(indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        self.model.serviceModel = item
        
        self.transitioningDelegate = self.transitionDelegate
        let attributes = self.collectionView.layoutAttributesForItem(at: indexPath)
        let attributesFrame = attributes?.frame ?? .zero
        let frameToOpenFrom = collectionView.convert(attributesFrame, to: self.collectionView.superview)
        self.transitionDelegate.openingFrame = frameToOpenFrom
        self.transitionDelegate.model = self.model
        
        self.presenter.cashFlowDetailCategory(transition: self.transitionDelegate, model: self.model)
    }
}
