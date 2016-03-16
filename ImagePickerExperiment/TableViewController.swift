//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Sandra Adams-Hallie on Mar/15/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit
import Foundation

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell")!
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SentMemeDetailViewController")
//        
//        cell.imageView? = memedImage
//        navigationController!.pushViewController(detailViewController, animated: true)
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableController = self.storyboard?.instantiateViewControllerWithIdentifier("SentMemesDetailViewController") as UIViewController!
            tableController.cell = self.memes[indexPath.row]
            self.navigationController?.pushViewController(tableController, animated: true)
        
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
//    // Swiping to the left should delete the list item.
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            tableView.removeAtIndex(indexPath.row)
//            //Whenever an item is removed, it should also be deleted in NSUserDefaults
//            NSUserDefaults.standardUserDefaults().setObject(memes, forKey: "memes")
//            //Update the table
//            
//            tableView.reloadData()
//        }
//        
//    }

    
    

}
