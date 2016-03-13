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
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var memeToolbar: UIToolbar!

    // Create memeTextAttributes dictionairy.
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates from UITextField
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        // Set the text custom attributes to override the defaults.
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        // center text, After assigning the defaultTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // The app signs up to be notified when the keyboard is showing.
        self.subscribeToKeyboardNotifications()
        
        // If the device has a camera, enable the camera button.
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    //Pick an image from an album.
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imagePickerView.image = image
    }

    func keyboardWillShow(notification: NSNotification){
        view.frame.origin.y = 0.0
        if self.bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
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
    
    // Make keyboard disappear when user clicks outside of text field.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Create a UIImage that combines the Image View and the Textfields
    func generateMemedImage() -> UIImage {
        hideNavigationItems(true)
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    //Write action share method
    @IBAction func shareWhenTapped(sender: AnyObject) {
       let viewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: [])
      presentViewController(viewController, animated: true, completion: nil)
    }
    
    func save() {
        let memeActivityViewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        memeActivityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                save(self)
            }
        }
        presentViewController(memeActivityViewController, animated: true, completion: nil)
    }


    private func hideNavigationItems(hide: Bool){
        memeToolbar.hidden = hide
        navigationController?.setNavigationBarHidden(hide, animated: false)

    }
    
}

