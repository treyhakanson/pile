//
//  ModalPageViewController.swift
//  ModalPageViewController
//
//  Created by David Hakanson on 10/12/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

//class ModalPageViewController: UIPageViewController {
class ModalPageViewController: UIViewController {
    var transitioner: ModalPageViewTransitioner = ModalPageViewTransitioner()
    
//    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
//        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init() {
        self.init(nibName: "ModalPageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
