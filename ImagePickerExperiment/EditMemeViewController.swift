//
//  EditMemeViewController.swift
//  ImagePickerExperiment
//
//  Created by Sandra Adams-Hallie on Mar/9/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class EditMemeViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // Global variables
    var editMeme: Meme?
    var userEdits = false
    var savedMeme: Meme?
    var savedIndex: Int? = nil

    func setTextFields(textFields: [UITextField!]){
        for textField in textFields{
            textField.delegate = self
            
            let memeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.whiteColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeWidthAttributeName : -5
            ]
            textField.defaultTextAttributes = memeTextAttributes
            textField.textAlignment = .Center
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultUI()

            if imagePickerView == nil {
                shareButton.enabled = false
            }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // The app signs up to be notified when the keyboard is showing.
        self.subscribeToKeyboardNotifications()
        
        // If the device has a camera, enable the camera button.
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    // Unsubscribe
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func setDefaultUI() {
        let textFieldArray = [topTextField, bottomTextField]
        if let editMeme = editMeme {
            navigationBar.topItem?.title = "Edit your Meme"
            
            topTextField.text = editMeme.topTextField
            bottomTextField.text = editMeme.bottomTextField
            imagePickerView.image = editMeme.originalImage
            
            userEdits = true
            setTextFields(textFieldArray)
        } else {
            //Set the title if creating a Meme */
            navigationBar.topItem?.title = "Create a Meme"
            setTextFields(textFieldArray)
        }
    }
    
    //Take a new photo.
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        pickAnImage(.Camera)
        
    }
    
    //Pick an image from an album.
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        pickAnImage(.PhotoLibrary)
    }
    
    
    func pickAnImage(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func keyboardWillShow(notification: NSNotification){
        view.frame.origin.y = 0.0
        if self.bottomTextField.isFirstResponder() {
            // Improved slider functionality.
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = 0
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
    
    // Make keyboard disappear when user clicks on return.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Create a UIImage that combines the Image View and the Textfields.
    func generateMemedImage() -> UIImage {
        hideNavigationItems(true)
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        hideNavigationItems(false)
        return memedImage
    }
    
    // Set to default when clear is pressed.
    func clearView() {
        topTextField.text = ""
        bottomTextField.text = ""
        imagePickerView.image = nil
        
    }
    
    // Cancel redirects to table view controller.
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        let tableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeTableViewController")
        self.navigationController?.presentViewController(tableViewController, animated: true,completion:nil)
    }

    // Write action share method.
    @IBAction func shareWhenTapped(sender: AnyObject) {
       let viewController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: [])
        viewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(self)
            }
        }
       presentViewController(viewController, animated: true, completion: nil)
    }
    
    @IBAction func clearWhenTapped(sender: AnyObject) {
        if MemesCollection.allMemes.count == 0 {
            clearView()
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

    // Test if OK to save.
    func okToSave() -> Bool {
        if topTextField.text == nil || bottomTextField.text == nil || imagePickerView.image == nil {
            return false
        } else {
            return true
        }
    }

    func save(sender: AnyObject) {
        if okToSave() {
            hideNavigationItems(true)
            let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
            if userEdits {
                if let editMeme = editMeme {
                    MemesCollection.updateMeme(atIndex: MemesCollection.indexOf(editMeme), withMeme: meme)
                }
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//
                let editMemeVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeTableViewController")
                self.navigationController?.presentViewController(editMemeVC, animated: true,completion:nil)
                
            } else {
                MemesCollection.addMeme(meme)
                dismissViewControllerAnimated(true, completion: nil)
            }
            
        } else {
            hideNavigationItems(false)
            let okAlert = UIAlertAction(title: "Save Eitherway", style: .Default, handler: { Void in
                self.topTextField.text = ""
                self.bottomTextField.text = ""
                self.imagePickerView.image = nil
                return
            })
            
            let editAlert = UIAlertAction(title: "Edit", style: .Default, handler: nil)
            alertUser(message: "Your meme misses something.", actions: [okAlert, editAlert])
        }
    }
    
    // Alert pops up when something is missing from the meme, unable to save.
    func alertUser(title: String! = "Oops!", message: String?, actions: [UIAlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        for action in actions {
            alert.addAction(action)
        }
        presentViewController(alert, animated: true, completion: nil)
    }


    func hideNavigationItems(hide: Bool){
        memeToolbar.hidden = hide
        navigationController?.setNavigationBarHidden(hide, animated: false)
        navigationBar.hidden = true

    }

}
