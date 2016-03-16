//
//  SentMemeCollectionViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit
import Foundation

let reuseIdentifier = "memeCell"

class SentMemeCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!

    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeCollectionViewCell: UICollectionViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: UIBarButtonItemStyle.Plain, target: self, action: "createMeme")

        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    func createMeme() {
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewControllerAnimated(true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = memeCollectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! CustomMemeCell
//        cell.imageView?.image = self.meme.memedImage
//
//        return cell
//    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier
        
        ("memeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        
        cell.memeImageView.image = meme.image
//        cell.setText(meme.top, bottomString: meme.bottom)
        let imageView = UIImageView(image: meme.memedImage)
        cell.backgroundView = imageView
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("collectionShowMeme", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestViewController : SentMemeDetailViewController = segue.destinationViewController as! SentMemeDetailViewController
        DestViewController.memeDetailVCImage.image = memedImage
    }
}
