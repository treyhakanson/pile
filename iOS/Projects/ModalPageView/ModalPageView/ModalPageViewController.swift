//
//  ModalPageViewController.swift
//  ModalPageView
//
//  Created by David Hakanson on 10/15/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

extension ModalPageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else { return orderedViewControllers.last }
        
        if index - 1 < 0 {
            return orderedViewControllers.last
        } else {
            return orderedViewControllers[index - 1]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.index(of: viewController) else { return orderedViewControllers.last }
        
        if index + 1 > orderedViewControllers.count - 1 {
            return orderedViewControllers.first
        } else {
            return orderedViewControllers[index + 1]
        }
        
    }
    
}

class ModalPageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController] = [
        TutorialPageOneViewController(nibName: "TutorialPageOneViewController", bundle: Bundle.main),
        TutorialPageTwoViewController(nibName: "TutorialPageTwoViewController", bundle: Bundle.main),
        TutorialPageThreeViewController(nibName: "TutorialPageThreeViewController", bundle: Bundle.main)
    ]
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let initialVC = orderedViewControllers.first {
            setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        }
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.backgroundColor = .red
        
    }

}
