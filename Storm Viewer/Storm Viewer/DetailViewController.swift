//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Samantha Gatt on 6/9/19.
//  Copyright © 2019 Samantha Gatt. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func imageSelected(_ imageName: String) {
        imageView.image = NSImage(named: imageName)
    }
}
