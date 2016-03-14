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

