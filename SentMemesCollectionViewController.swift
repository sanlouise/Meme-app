//
//  SentMemesCollectionViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit
import Foundation

let reuseIdentifier = "cell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    struct Meme {
        var topTextField: String!
        var bottomTextField: String!
        var originalImage: UIImage!
        var memedImage: UIImage!
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeCollectionViewCell: UICollectionViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = memeCollectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        cell.image.image = self.meme[indexPath.row]
        
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("collectionShowMeme", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //OR --  var DestViewCntroller : SentMemeDetailViewController = segue.destinationViewController as SentMemeDetailViewController
        
        if segue.identifier == "collectionShowMeme" {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            // Now pass data to the next controller
            let viewcontroller = segue.destinationViewController as! SentMemeDetailViewController
            Meme.memedImage = Meme.memedImage
        }
        
    }
    
    
}
