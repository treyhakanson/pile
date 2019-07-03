//
//  ButtonsPageViewController.swift
//  ModalPageView
//
//  Created by David Hakanson on 10/15/16.
//  Copyright © 2016 David Hakanson. All rights reserved.
//

import UIKit

class TutorialPageThreeViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var leftButtonBottom: UIView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var rightButtonBottom: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func leftButtonTapped(_ sender: AnyObject) {
        print("left button tapped")
    }
    
    @IBAction func rightButtonTapped(_ sender: AnyObject) {
        print("right button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    
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
        
        leftButton.layer.cornerRadius = 5.0
        leftButtonBottom.layer.cornerRadius = 5.0
        
        rightButton.layer.cornerRadius = 5.0
        rightButtonBottom.layer.cornerRadius = 5.0
    }

}
