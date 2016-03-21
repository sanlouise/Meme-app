//
//  SentMemeDetailViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/16/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var memeDetailVCImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memeDetailVCImage.image = meme.memedImage
    }
    

    @IBAction func editMeme(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//
        let editMemeController = self.storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController")
            self.navigationController?.presentViewController(editMemeController, animated: true,completion:nil)
        
        }

}





