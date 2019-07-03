//
//  ViewController.swift
//  ModalPageViewController
//
//  Created by David Hakanson on 10/12/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTapped(_ sender: UIButton) {
        let modalPageVC = ModalPageViewController()
        self.present(modalPageVC, animated: true)
        
    }

}

