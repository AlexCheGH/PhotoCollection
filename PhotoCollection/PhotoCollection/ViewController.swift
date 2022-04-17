//
//  ViewController.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let imageManager = ImageManager()
        
        imageManager.getImageInfo()
 
    }
}


