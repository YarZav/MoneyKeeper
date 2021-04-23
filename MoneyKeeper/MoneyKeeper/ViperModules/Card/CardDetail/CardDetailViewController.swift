//  
//  CardDetailViewController.swift
//  MoneyKeeper
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

// MARK: - CardDetailViewController
class CardDetailViewController: BaseViewController {
    
    var presenter: CardDetailPresenterProtocol!
    var model: CardModel!
    private var detailView: CardDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
}

// MARK: - Actions
extension CardDetailViewController {
    
    @objc private func closeAction() {
        self.presenter.popViewController()
    }
    
    @objc private func deleteAction() {
        self.presenter.deleteModel(self.model)
    }
}

// MARK: - Privates
extension CardDetailViewController {
    
    private func createUI() {
        self.view.alpha = 0
    }
    
    private func createSubViews() {
        self.detailView = CardDetailView(model: self.model, transition: false)
        self.view.addSubview(self.detailView)
        self.detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "CloseBlack"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-15)
            $0.width.height.equalTo(34)
        }
        
        let deleteButton = UIButton(type: .custom)
        deleteButton.backgroundColor = .darkRed
        deleteButton.setTitle("CardDetailDeleteCard".localized(), for: .normal)
        deleteButton.titleLabel?.textColor = .white
        deleteButton.layer.cornerRadius = 8
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        self.view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(44)
        }
    }
}

// MARK: - Publics
extension CardDetailViewController {
    
    public func dismissAnimateStart() {
        self.view.alpha = 0
    }
    
    public func presentAnimate() {
        self.view.alpha = 0
    }
    
    public func dismissAnimate() {
        self.view.alpha = 0
    }
    
    public func presentAnimateCompletion() {
        self.view.alpha = 1
        self.createSubViews()
    }
}

// MARK: - CardDetailViewProtocol
extension CardDetailViewController: CardDetailViewProtocol { }
