//
//  MemeTableViewCell.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/20/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
 
}