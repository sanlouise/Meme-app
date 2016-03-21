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
    var rightButton: UIBarButtonItem!
    var savedIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editMeme")
        self.navigationItem.rightBarButtonItem = rightButton
        memeDetailVCImage.image = meme.memedImage
    }
    

//    func editMeme() {
//        
//        let memeEditorController = self.storyboard?.instantiateViewControllerWithIdentifier("EditMemeViewController") as! EditMemeViewController
//        memeEditorController.savedMeme = self.meme
//        memeEditorController.savedIndex = self.savedIndex
//        self.navigationController?.pushViewController(EditMemeViewController, animated: true)
//        EditMemeViewController.editMeme = meme
//        
//        
//    }

}





