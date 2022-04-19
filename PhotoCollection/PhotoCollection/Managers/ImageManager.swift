//
//  ImageManager.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import Foundation
import UIKit
import Combine

class ImageManager {
    
    @Published  var model: [ImageEntry] = []
    
    var modelPublisher: AnyPublisher<[ImageEntry], Never> {
        return $model.map{ $0 }
        .eraseToAnyPublisher()
    }
    
    func getImageInfo(number: Int) {
        let networkManager = NetworkManager<[UnsplashImageInfo]>()
        networkManager.makeImagesInfoRequest(numberOfResults: number) { results in
            results?.forEach{ element in
                let entry = ImageEntry(id: element.id,
                                       width: element.width,
                                       height: element.height,
                                       image: nil,
                                       authorUsername: element.user?.username,
                                       link: element.urls?.regular)
                self.model.append(entry)
            }
        }
    }
    
    func getImage(id: String?, completion: @escaping() -> Void) {
        let networkManager = NetworkManager<Data>()
        var link: String?
        for item in model {
            if item.id == id {
                link = item.link
            }
        }
        
        networkManager.makeImageRequest(from: link) { image in
            self.changeImageInModel(id: id, image: image)
            completion()
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
