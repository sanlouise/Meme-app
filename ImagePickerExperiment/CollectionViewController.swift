//
//  CollectionViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
}

class CollectionViewController: UICollectionViewController {

}
