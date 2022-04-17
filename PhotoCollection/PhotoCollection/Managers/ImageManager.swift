//
//  ImageManager.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import Foundation
import UIKit

class ImageManager {
    
    var model: [ImageEntry] = []
    
    func getImageInfo() {
        let networkManager = NetworkManager<[UnsplashImageInfo]>()
        networkManager.makeImagesInfoRequest(numberOfResults: 10) { results in
            results?.forEach{ element in
                let entry = ImageEntry(id: element.id, width: element.width, height: element.height, image: nil, authorUsername: element.user?.username)
                self.model.append(entry)
            }
        }
    }
    
    func getImage(from link: String?, id: String?) {
        let networkManager = NetworkManager<Data>()
        networkManager.makeImageRequest(from: link) { image in
            self.changeImageInModel(id: id, image: image)
        }
    }
    
    private func changeImageInModel(id: String?, image: UIImage?) {
        model.forEach{
            if $0.id == id {
                $0.image = image
            }
        }
    }
    
}
