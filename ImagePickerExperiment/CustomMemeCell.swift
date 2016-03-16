//
//  CustomMemeCell.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class CustomMemeCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageCell: UIImageView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
    }
    
    
    
}
