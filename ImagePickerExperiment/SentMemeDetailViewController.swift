//
//  SentMemeDetailViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/16/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class SentMemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeDetailVCImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memeDetailVCImage.image = memedImage

    }

}





