//
//  Photo.swift
//  FlickrApp
//
//  Created by Jordan Porter on 01/07/2024.
//

import Foundation

struct Photo: Identifiable {
    let id: String
    let title: String
    let owner: String
    let urlString: String

    var url: URL? {
        return URL(string: urlString)
    }
}

extension Photo: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case owner = "ownername"
        case urlString = "url_m"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        owner = try container.decode(String.self, forKey: .owner)
        urlString = try container.decodeIfPresent(String.self, forKey: .urlString) ?? ""
    }
}

extension Photo {
    static var dummy: Self {
        .init(
            id: "53828846147",
            title: "Wood Storks",
            owner: "walterjeffords",
            urlString: "https://live.staticflickr.com/65535/53827544342_4beb3676a5.jpg"
        )
    }
}
