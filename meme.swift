//
//  meme.swift
//  ImagePickerExperiment
//
//  Created by Sandra Adams-Hallie on Mar/13/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit
import Foundation

var memedImage: UIImage!

//Initialize meme object.
struct Meme {
    var topTextField: String!
    var bottomTextField: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.topTextField = top
        self.bottomTextField = bottom
        self.originalImage = image
        self.memedImage = memedImage
    }
}

/*  Convenience methods, inspired by Meme app from RyanCCollins, https://github.com/RyanCCollins/ */

func ==(lhs: Meme, rhs: Meme) -> Bool {
    return lhs.memedImage == rhs.memedImage
}

struct MemesCollection {
    
    // Locate meme storage location.
     static func getStoredMemes() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    // Count the number of memes.
    static func countMemes() -> Int {
        return getStoredMemes().memes.count
    }
    
    // Get memes from the delegate.
    static var allMemes: [Meme] {
        return getStoredMemes().memes
    }

    // Return meme at a specific index.
    static func returnMeme(atIndex index: Int) -> Meme {
        return allMemes[index]
    }
    
    // Update meme with a new meme at a specific index.
    static func updateMeme(atIndex index: Int, withMeme meme: Meme) {
        getStoredMemes().memes.append(meme)
    }
    
    // Add a meme to the collection.
    static func addMeme(meme: Meme) {
        getStoredMemes().memes.append(meme)
    }
   
//     Find the index of a specific meme.
    static func indexOf(meme: Meme) -> Int {
        // Return first index of meme.
        if let index = allMemes.indexOf({$0 == meme}) {
            return Int(index)
        } else {
            return allMemes.count
        }
    }
}

