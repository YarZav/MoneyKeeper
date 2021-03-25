//
//  CardsViewController.swift
//  MoneyKeeper
//
//  Created by admin on 15/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - CashFlowViewController
class CardsViewController: BaseViewController {
    
    //Properties
    public var presenter: CardsPresenterProtocol!
    private var searchBar = UISearchBar(backgroundColor: .blueGray)
    private var collectionView: GradientCollectionView!
    private var noContentView = LabelView()
    private var models = [CardModel]()
    
    private let transition = CardDetailTransitionDelegate()
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewLoaded()
    }
}

// MARK: - CardsViewControllerProtocol
extension CardsViewController: CardsViewControllerProtocol {
    
    func updateStringLocalization() {
        self.navigationItem.title = "CardsTitle".localized()
        self.noContentView.display("CardsCanDisplayCard")
    }
    
    func setModels(_ models: [CardModel]) {
        guard models.count > 0 else { return }

        self.models = []
        self.noContentView.removeFromSuperview()
//        if !self.view.subviews.contains(self.collectionView) {
//            self.view.addSubview(self.collectionView)
//            self.collectionView.snp.makeConstraints {
//                $0.top.equalToSuperview().offset(self.getNavigationbarHeight())
//                $0.left.right.equalToSuperview()
//                $0.bottom.equalToSuperview().offset(-self.getTabBarHeight())
//            }
//        }
        
        self.models = models
        self.collectionView.reloadDataAndSetGradient()
    }
    
    func insertModels(_ models: [CardModel]) {
        guard models.count > 0 else { return }

        if self.models.isEmpty {
            self.setModels(models)
        } else {
            self.models.append(contentsOf: models)
            self.collectionView.reloadDataAndSetGradient()
        }
    }
    
    func deleteModel(_ model: CardModel) {
        self.models.removeAll { $0.id == model.id }
        self.collectionView.reloadDataAndSetGradient()
    }
    
    func getCardTitle(_ callback: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "CardsEnterName".localized(), message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "CardsPlaceHolder".localized()
        })
        alert.addAction(UIAlertAction(title: "CardsOk", style: .default, handler: { [weak alert] (action) -> Void in
            if let alert = alert, let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty {
                callback(text)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoContentView() {
        if !self.view.subviews.contains(self.noContentView) {
            self.view.addSubview(self.noContentView)
            self.noContentView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        self.models = []
        self.collectionView.removeFromSuperview()
        self.noContentView.display("CardsCanDisplayCard")
    }
}

// MARK: - Actions
extension CardsViewController {
    
    @objc private func scannerAction() {
        self.presenter.presentCardScanner()
    }
    
    @objc private func searchAction() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = searchBar
        
        self.searchBar.layoutIfNeeded()
        self.searchBar.becomeFirstResponder()
    }
}

// MARK: - Privates
extension CardsViewController {
    
    private func createUI() {
        self.navigationItem.title = "CardsTitle".localized()
        self.view.backgroundColor = .blueGray
        
        self.searchBar.delegate = self
        self.searchBar.tintColor = .black
        
        self.createLeftBarButtonItem()
        self.createRightBarButtonItem()

        self.collectionView = GradientCollectionView(cells: [CardCell.self], dataSource: self, delegate: self)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    private func createLeftBarButtonItem() {
        let leftImage = UIImage(named: "SearchBlack")?.resizeImage(30, opaque: false).withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(searchAction))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func createRightBarButtonItem() {
        let rightImage = UIImage(named: "Scanner")?.resizeImage(30, opaque: false).withRenderingMode(.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(scannerAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func hideSearchBar() {
        self.searchBar.text = nil
        self.navigationItem.titleView = nil
        self.createLeftBarButtonItem()
        self.createRightBarButtonItem()
    }
}

// MARK: - UICollectionViewDataSource
extension CardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueCell(indexPath: indexPath)
        let model = self.models[indexPath.row]
        cell.display(model)
        
        let offset: CGFloat = 32.0
        let width = (UIScreen.main.bounds.width - offset * 2)
        cell.dropShadow(width: width, height: (width / 3 * 2))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 32 * 2)
        return CGSize(width: width, height: (width / 3 * 2))
    }
}

// MARK: - UICollectionViewDelegate
extension CardsViewController: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
        if (self.searchBar.text ?? "").isEmpty {
            self.hideSearchBar()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView.setTopGradientPoint(scrollView)
        self.collectionView.setBottomGradientPoint(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        let attributes = self.collectionView.layoutAttributesForItem(at: indexPath)
        let attributesFrame = attributes?.frame ?? .zero
        let frameToOpenFrom = collectionView.convert(attributesFrame, to: self.collectionView.superview)
        
        self.transition.openingFrame = frameToOpenFrom
        self.transition.model = model
        self.transitioningDelegate = self.transition

        self.presenter.didSelectCard(transition: self.transition)
    }
}

// MARK: - UISearchBarDelegate
extension CardsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.searchCards(by: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        self.presenter.searchCards(by: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.hideSearchBar()
        self.presenter.searchCards(by: searchBar.text)
    }
}

