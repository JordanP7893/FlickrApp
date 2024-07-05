//
//  PhotoResponse.swift
//  FlickrApp
//
//  Created by Jordan Porter on 05/07/2024.
//

import Foundation

struct PhotoResponse: Decodable {
    struct PhotosContainer: Decodable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: Int
        let photo: [Photo]
    }

    let photos: PhotosContainer
}

extension PhotoResponse {
    static var dummy: Self {
        .init(photos: .init(page: 1, pages: 1, perpage: 1, total: 1, photo: .dummyData))
    }
}
