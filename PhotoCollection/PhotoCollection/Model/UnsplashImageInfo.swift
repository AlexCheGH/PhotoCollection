//
//  RawRandomImageResponse.swift
//  PhotoCollection
//
//  Created by Aliaksandr Chekushkin on 4/17/22.
//

import Foundation

// MARK: - UnsplashImage
class UnsplashImageInfo: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, description, width, height, urls, user
        case altDescription = "alt_description"
    }

    init(id: String?, width: Int?, height: Int?, description: String?, altDescription: String?, urls: Urls?, user: User?) {
        self.id = id

        self.width = width
        self.height = height

        self.description = description
        self.altDescription = altDescription
        self.urls = urls
        self.user = user
    }
    
    // MARK: - User
    class User: Codable {
        let id: String?
        let username: String?
        let name: String?
        let firstName: String?
        let lastName: String?

        enum CodingKeys: String, CodingKey {
            case id, username, name
            case firstName = "first_name"
            case lastName = "last_name"
        }

        init(id: String?, username: String?, name: String?, firstName: String?, lastName: String?) {
            self.id = id
            self.username = username
            self.name = name
            self.firstName = firstName
            self.lastName = lastName
        }
    }

    // MARK: - Urls
    class Urls: Codable {
        let raw: String?
        let full: String?
        let regular: String?
        let small: String?
        let thumb: String?
        let smallS3: String?

        enum CodingKeys: String, CodingKey {
            case raw = "raw"
            case full = "full"
            case regular = "regular"
            case small = "small"
            case thumb = "thumb"
            case smallS3 = "small_s3"
        }

        init(raw: String?, full: String?, regular: String?, small: String?, thumb: String?, smallS3: String?) {
            self.raw = raw
            self.full = full
            self.regular = regular
            self.small = small
            self.thumb = thumb
            self.smallS3 = smallS3
        }
    }
}

