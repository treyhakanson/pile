//
//  ModalPageViewTransitioner.swift
//  ModalPageViewController
//
//  Created by David Hakanson on 10/12/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

extension ModalPageViewTransitioner {
    @objc(animationControllerForPresentedController:presentingController:sourceController:) func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    @objc(animationControllerForDismissedController:) func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension ModalPageViewTransitioner: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let con = transitionContext.containerView
        if let vc2 = transitionContext.view(forKey: .to) {
            con.addSubview(vc2)
            vc2.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            vc2.alpha = 0
            UIView.animate(withDuration: 0.25, animations: { 
                vc2.alpha = 1
                vc2.transform = CGAffineTransform.identity
            }) { _ in
                transitionContext.completeTransition(true)
            }
        } else if let vc1 = transitionContext.view(forKey: .from) {
            UIView.animate(withDuration: 0.25, animations: { 
                vc1.alpha = 0
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
}

class ModalPageViewTransitioner: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPageViewPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class ModalPageViewPresentationController: UIPresentationController {

    override func presentationTransitionWillBegin() {
        let vc = self.presentingViewController
        let v = vc.view
        let con = self.containerView!
        let shadow = UIView(frame: con.bounds)
        shadow.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        shadow.alpha = 0
        con.insertSubview(shadow, at: 0)
        shadow.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tc = vc.transitionCoordinator!
        tc.animate(alongsideTransition: { _ in shadow.alpha = 1 }) { _ in
                v?.tintAdjustmentMode = .dimmed
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let vc = self.presentingViewController
        let v = vc.view
        let con = self.containerView!
        let shadow = con.subviews[0]
        let tc = vc.transitionCoordinator!
        tc.animate(alongsideTransition: { _ in
            shadow.alpha = 0
            }) { _ in
                v?.tintAdjustmentMode = .automatic
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let conSize = containerView!.frame.size
        return CGRect(x: (conSize.width - conSize.width*0.75)/2, y: (conSize.height - conSize.height*0.75)/2, width: conSize.width*0.75, height: conSize.height*0.75)
    }
    
    override func containerViewWillLayoutSubviews() {
        let v = self.presentedView!
        v.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        v.translatesAutoresizingMaskIntoConstraints = false
    }
    
}




























