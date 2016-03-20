//
//  SentMemeDetailViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/16/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var memeDetailVCImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeDetailVCImage.image = memedImage
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "memeEditorVC" {
            
            let editVC = segue.destinationViewController as! EditMemeViewController
            editVC.editMeme = meme
            
        }
    }

}





