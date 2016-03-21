//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        memes = MemesCollection.allMemes
        
        if MemesCollection.countMemes() == 0 {
            let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController")
            let createMemeViewController = object as! EditMemeViewController
            presentViewController(createMemeViewController, animated: true, completion: nil)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.tableView!.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController")
        let createMemeViewController = object as! EditMemeViewController
        presentViewController(createMemeViewController, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.textLabelCell.text = "\(meme.topTextField) \(meme.bottomTextField)"
        cell.tableImage.image = meme.originalImage
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // After selecting a meme, show detail view controller.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
    }
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            memes.removeAtIndex(indexPath.row)
            self.tableView!.reloadData()
        } 
    }

}
