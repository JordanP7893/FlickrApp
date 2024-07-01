//
//  Photo.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import Foundation

struct Photo {
    let title: String
    let owner: String
    let urlString: String

    var url: URL? {
        return URL(string: urlString)
    }
}

extension Photo {
    static var dummy: Self {
        .init(
            title: "Wood Storks",
            owner: "walterjeffords",
            urlString: "https://live.staticflickr.com/65535/53827544342_4beb3676a5.jpg"
        )
    }
}
