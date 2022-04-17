//
//  NetworkManager.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import Foundation
import UIKit

class NetworkManager<T: Codable> {
    
    
    func makeImagesInfoRequest(numberOfResults: Int, completion: @escaping(T?) -> Void ) {
        let endpoint = ImageInfosEndpoint(numberOfResults: numberOfResults)
        makeRequest(endpoint: endpoint) { data in
            let result = self.decode(data)
            completion(result)
        }
    }
    
    func makeImageRequest(from link: String?, completion: @escaping(UIImage?) -> Void) {
        let endpoint = ImageURLEndpoint(imageLink: link)
        makeRequest(endpoint: endpoint) { data in
            let image = UIImage(data: data)
            completion(image)
        }
    }
    
    
    func makeRequest(endpoint: Endpointable, completion: @escaping (Data) -> Void ) {
        let dataLoader = DataLoader()
        
        dataLoader.request(endpoint) { result in
            switch result {
            case .failure(.urlIsNotValid):
                print("URL is not valid. Check the URL.")
            case .success(let data):
                completion(data)
            case .failure(.wrongMap):
                print("An error occured when trying to map the result.")
            }
        }
    }
        //пытается сделать декод даты из даты. нужен фикс
    
    private func decode(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T?.self, from: data)
        
        return result
    }
}




enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

enum NetworkError: Error {
    case urlIsNotValid
    case wrongMap
}
