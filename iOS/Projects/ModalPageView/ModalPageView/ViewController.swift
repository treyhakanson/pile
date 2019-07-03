//
//  ViewController.swift
//  ModalPageView
//
//  Created by David Hakanson on 10/15/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = ModalPageViewController(nibName: "ModalPageViewController", bundle: Bundle.main)
//        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true) { _ in
            print("Presented ModalPageViewController.")
        }
        
    }

}

