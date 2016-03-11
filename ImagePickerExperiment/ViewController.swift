//
//  ViewController.swift
//  ImagePickerExperiment
//
//  Created by Sandra Adams-Hallie on Mar/9/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    let memeTextAttributes = [
        
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
//        self.topTextField.textAlignment = .Center
//        self.bottomTextField.textAlignment = .Center
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
    }
    
    // Unsubscribe
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    //Take a new photo.
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //Pick an image from an album.
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Set the chosen image.
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
            // Cancel choosing an image.
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Shift the view in response to the UIKeyboardWillShowNotification:
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y = 0.0
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    // Shift the view in response to the UIKeyboardWillShowNotification:
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    // NSNotification objects encapsulate information so that it can be broadcast to other objects by an NSNotificationCenter object.
    // The app signs up to be notified when the keyboard is showing.
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    // Get the keyboard height from the notification’s userInfo dictionary:
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
//    // Create a UIImage that combines the Image View and the Textfields
//    func generateMemedImage() -> UIImage {
//        // Hide toolbar and navigation
//        self.memeToolbar.hidden = true
//        // render view to an image
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
//        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return memedImage
//    }
//    
//    func save() {
//        //Create the meme
//        var meme = Meme( text: textField.text!, image:
//            self.imageView.image, memedImage: memedImage())
//        
//        // Add it to the memes array in the Application Delegate
//        (UIApplication.sharedApplication().delegate as!
//            AppDelegate).memes.append(meme)
//    }
}

