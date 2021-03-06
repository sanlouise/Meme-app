//
//  SentMemeDetailViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/16/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var userEdits = true

    @IBOutlet weak var memeDetailVCImage: UIImageView!
    
    var meme: Meme!
    var rightButton: UIBarButtonItem!
    var savedIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editMeme")
        self.navigationItem.rightBarButtonItem = rightButton
        memeDetailVCImage.image = meme.memedImage
    }
    

    func editMeme() {
        
        let editController = storyboard?.instantiateViewControllerWithIdentifier("EditMemeViewController") as! EditMemeViewController
            editController.editMeme = meme
            userEdits = true
            navigationController?.presentViewController(editController, animated: true, completion: nil)
        
    }

}





