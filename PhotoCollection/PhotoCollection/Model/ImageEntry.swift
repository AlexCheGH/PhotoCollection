//
//  ImageEntry.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import Foundation
import UIKit

class ImageEntry {
    var id: String?
    var width: Int?
    var height: Int?
    var image: UIImage?
    var authorUsername: String?
    var link: String?
    
    init(id: String?, width: Int?, height: Int?, image: UIImage?, authorUsername: String?, link: String?) {
        self.id = id
        self.width = width
        self.height = height
        self.image = image
        self.authorUsername = authorUsername
        self.link = link
    }
}


