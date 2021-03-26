//
//  CashFlowCategoryAddViewController.swift
//  MoneyKeeper
//
//  Created by admin on 20/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//
import UIKit
import YZNotificationView

// MARK: - CashFlowCategoryAddViewController
class CashFlowCategoryAddViewController: BaseViewController {
    
    //Properties
    public var presenter: CashFlowCategoryAddPresenterProtocol!
    private var imageView = UIImageView()
    private var textField = UITextField()
    private var collectionView: GradientCollectionView!
    private var items = [String]()
    private var imageName: String?
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - CashFlowCategoryAddViewControllerProtocol
extension CashFlowCategoryAddViewController: CashFlowCategoryAddViewControllerProtocol {
    
    func setItems(_ items: [String]) {
        self.items = items
        self.collectionView.reloadDataAndSetGradient()
    }
}

// MARK: - Privates
extension CashFlowCategoryAddViewController {
    
    private func createUI() {
        self.view.backgroundColor = .anthracite
        self.navigationItem.title = "CashFlowCategoryAddAddCategory".localized()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        let imageViewContainer = UIView(backgroundColor: .darkViolet)
        imageViewContainer.layer.cornerRadius = 10
        self.view.addSubview(imageViewContainer)
//        imageViewContainer.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(self.getNavigationbarHeight() + 32)
//            $0.centerX.equalToSuperview()
//            $0.width.height.equalTo(70)
//        }
        
        self.imageView.image = UIImage(named: "WhiteQuestion")
        imageViewContainer.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        self.textField.layer.cornerRadius = 5
        self.textField.placeholder = "CashFlowCategoryAddCategory".localized()
        self.textField.backgroundColor = .white
        self.view.addSubview(self.textField)
        self.textField.snp.makeConstraints {
            $0.top.equalTo(imageViewContainer.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }
        
        let saveButton = UIButton(type: .custom)
        saveButton.backgroundColor = .darkViolet
        saveButton.setTitle("CashFlowCategoryAddAddCategory".localized(), for: .normal)
        saveButton.titleLabel?.textColor = .white
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }
        
        self.collectionView = GradientCollectionView(cells: [CashFlowCategoryAddCell.self], dataSource: self, delegate: self)
        self.collectionView.backgroundColor = UIColor.anthracite
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.textField.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(saveButton.snp.top).offset(-32)
        }
    }
    
    private func getCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CashFlowCategoryAddCell = self.collectionView.dequeueCell(indexPath: indexPath)
        let item = self.items[indexPath.row]
        cell.display(item)
        return cell
    }
}

// MARK: - Actions
extension CashFlowCategoryAddViewController {
    
    @objc private func addAction() {
        self.presenter.saveCategoryModel(title: self.textField.text, imageName: self.imageName)
    }
    
    @objc private func tapViewAction() {
        self.textField.endEditing(true)
    }
}

// MARK: - UICollectionViewDataSource
extension CashFlowCategoryAddViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.getCell(for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowCategoryAddViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //FIXME: Struct
        return CGSize(width: 70, height: 70)
    }
}

// MARK: - UICollectionViewDelegate
extension CashFlowCategoryAddViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageName = self.items[indexPath.row]
        self.imageView.image = UIImage(named: self.items[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textField.endEditing(true)
        self.collectionView.setTopGradientPoint(scrollView)
        self.collectionView.setBottomGradientPoint(scrollView)
    }
}
