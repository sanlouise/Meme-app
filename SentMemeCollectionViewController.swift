//
//  SentMemeCollectionViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

let reuseIdentifier = "memeCell"

class SentMemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: UIBarButtonItemStyle.Plain, target: self, action: "createMeme")
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
    
    func createMeme() {
                if let navigationController = self.navigationController {
            navigationController.popToRootViewControllerAnimated(true)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCollectionCell", forIndexPath: indexPath) as! CustomMemeCell

        let meme = memes[indexPath.item]
        // display the meme
        cell.memeImageCell.image = meme.memedImage

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemesDetailViewController") as! SentMemeDetailViewController
        detailController.meme = self.memes [indexPath.item]
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
