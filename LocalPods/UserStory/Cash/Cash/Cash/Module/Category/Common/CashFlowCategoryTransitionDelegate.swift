//
//  CashFlowCategoryTransitionDelegate.swift
//  MoneyKeeper
//
//  Created by Yaroslav Zavyalov on 03/03/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import Business

// MARK: - CashFlowCategoryTransitionDelegate
class CashFlowCategoryTransitionDelegate: NSObject {
    var openingFrame: CGRect?
//    var model: CategoryModel!
}

// MARK: - UIViewControllerTransitioningDelegate
extension CashFlowCategoryTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentationAnimator = CashFlowDetailPresentationAnimator()
        presentationAnimator.openingFrame = openingFrame ?? .zero
//        presentationAnimator.model = model
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissAnimator = CashFlowDetailDismissalAnimator()
        dismissAnimator.openingFrame = openingFrame ?? .zero
//        dismissAnimator.model = model
        return dismissAnimator
    }
}

// MARK: - PresentationAnimator
class CashFlowDetailPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    //Properties
    var openingFrame: CGRect?
//    var model: CategoryModel!
    
    //Transitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
//        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CashFlowCategoryDetailViewController else { return }
        
        let animationDuration = self.transitionDuration(using: transitionContext)
        let fromViewFrame = fromViewController.view.frame
//        let snapshotView = CashFlowCategoryDetailView(model: self.model, transition: true)
//        snapshotView.frame = self.openingFrame ?? .zero
//
//        let containerView = transitionContext.containerView
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(snapshotView)
//        
//        snapshotView.layoutIfNeeded()
//        UIView.animate(withDuration: animationDuration, animations: {
//            toViewController.presentAnimate()
//            
//            snapshotView.frame = fromViewFrame
//            snapshotView.presentAnimate()
//            snapshotView.layoutIfNeeded()
//        }) { (finished) in
//            snapshotView.removeFromSuperview()
//            toViewController.presentAnimateCompletion()
//            
//            transitionContext.completeTransition(finished)
//        }
    }
}

// MARK: - DismissalAnimator
class CashFlowDetailDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    //Properties
    var openingFrame: CGRect?
//    var model: CategoryModel!
    
    //Transitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CashFlowCategoryDetailViewController else { return }
        
        let animationDuration = self.transitionDuration(using: transitionContext)
//        let snapshotView = CashFlowCategoryDetailView(model: self.model, transition: false)
//        snapshotView.frame = fromViewController.view.frame
//        fromViewController.dismissAnimateStart()
//
//        let containerView = transitionContext.containerView
//        containerView.addSubview(snapshotView)
//
//        snapshotView.layoutIfNeeded()
//        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
//            fromViewController.dismissAnimate()
//
//            snapshotView.frame = self.openingFrame!
//            snapshotView.dismissAnimate()
//            snapshotView.layoutIfNeeded()
//        }) { (finished) -> Void in
//            snapshotView.removeFromSuperview()
//            fromViewController.view.removeFromSuperview()
//
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
    }
}
