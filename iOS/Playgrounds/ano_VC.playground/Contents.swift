//
//  CreateNewEventViewController.swift
//  ANO
//
//  Created by David Hakanson on 12/24/15.
//  Copyright © 2015 Mychal Culpepper. All rights reserved.
//

import UIKit

class CreateNewEventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    //MARK: Actions
    @IBAction func postButtonClicked(sender: UIButton) {
        if validateUserInput() {
            print("All User Input is Valid")
        }
    }
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        resignKeyboard()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Main Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        timeTextField.delegate = self
        addressTextField.delegate = self
        descriptionTextField.delegate = self
        
        eventImageView.userInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        //TODO: For some reason, next responder is always viewed as nil, keyboard is always resigned
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    //MARK: Helper functions
    func resignKeyboard() {
        titleTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        eventImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func validateUserInput() -> Bool {
        var invalidCount: Int = 0
        
        let titleInput = Input(mInputName: "Title", mInputTextField: titleTextField)
        let timeInput = Input(mInputName: "Time", mInputTextField: timeTextField)
        let addressInput = Input(mInputName: "Address", mInputTextField: addressTextField)
        let descriptionInput = Input(mInputName: "Description", mInputTextField: descriptionTextField)
        
        let inputArr = [titleInput, timeInput, addressInput, descriptionInput]
        
        for (_, val) in inputArr.enumerate() {
            if val.inputText == "" {
                val.applyInvalidInputStyling()
                invalidCount++
            }
        }
        
        if invalidCount > 0 {
            return false
        }else {
            return true
        }
        
    }
    
    //MARK: Classes
    class Input {
        var inputText: String
        var inputName: String
        var inputTextField: UITextField
        
        init(mInputName: String, mInputTextField: UITextField) {
            inputName.self = mInputName
            inputText.self = mInputTextField.text!
            inputTextField.self = mInputTextField
        }
        
        func applyInvalidInputStyling() {
            inputTextField.attributedPlaceholder = NSAttributedString(string: "\(inputName.self)", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
        }
    }
}














