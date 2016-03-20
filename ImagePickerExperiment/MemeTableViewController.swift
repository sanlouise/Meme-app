//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableImage: UIImageView!
    @IBOutlet weak var memeTextLabel: UILabel!
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if MemesCollection.countMemes() == 0 {
            let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController")
            let createMemeViewController = object as! EditMemeViewController
            presentViewController(createMemeViewController, animated: true, completion: nil)
        }

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        
        let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController")
        let createMemeViewController = object as! EditMemeViewController
        presentViewController(createMemeViewController, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell", forIndexPath: indexPath)
        let meme = memes[indexPath.row]
        tableImage.image = meme.originalImage
        memeTextLabel.text = "\(meme.topTextField) \(meme.bottomTextField)"
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // After selecting a meme, show detail view controller.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    //     Swiping to the left should delete the list item.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }

    
    

}
