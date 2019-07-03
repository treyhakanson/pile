//
//  NoButtonsViewController.swift
//  ModalPageView
//
//  Created by David Hakanson on 10/15/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class TutorialPageTwoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLayoutSubviews() {
        containerView.layer.cornerRadius = 10.0
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1.0
    }

}
