//
//  SentMemeCollectionViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCollectionCell"

class SentMemeCollectionViewController: UICollectionViewController  {
    
    var memes: [Meme]!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.hidden = false
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        collectionView!.reloadData()
    }
    @IBAction func addMeme(sender: AnyObject) {
        let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController")
        let createMemeViewController = object as! EditMemeViewController
        presentViewController(createMemeViewController, animated: true, completion: nil)
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("customCollectionCell", forIndexPath: indexPath) as! CustomMemeCell

        let meme = memes[indexPath.item]
        // display the meme
        cell.memeImageCell.image = meme.memedImage

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.meme = self.memes [indexPath.item]
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
