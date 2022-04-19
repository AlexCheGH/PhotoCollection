//
//  Endpoint.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import Foundation

protocol Endpointable {
    var url: URL? { get }
}

struct ImageInfosEndpoint: Endpointable {
    let numberOfResults: Int
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist") else {
                fatalError("Couldn't find file 'ApiKey.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "unsplash_key") as? String else {
                fatalError("Couldn't find key 'unsplash_key' in 'ApiKey.plist'.")
            }
            return value
        }
    }
}

extension ImageInfosEndpoint {
    var url: URL? {
        let scheme = "https://"
        let host = "api.unsplash.com"
        let path = "/photos/random/"
        let query = "?client_id=\(apiKey)&count=\(numberOfResults)" //basic. Need to add "component.query ..." builder for a more serious approach
        let stringURL = scheme + host + path + query
        
        return URL(string: stringURL)
    }
}

struct ImageURLEndpoint: Endpointable {
    let imageLink: String?
    
    var url: URL? {
        return URL(string: imageLink!)
    }
}
